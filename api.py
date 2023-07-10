from audioop import mul
import json
from flask import Flask, render_template, request, redirect, url_for
import requests
import paramiko
import mysql.connector
import psutil

mydb = mysql.connector.connect(
    host="localhost",
    user="root",
    password="",
    database="db-test",)
mycursor = mydb.cursor()


app = Flask(__name__)


@app.route("/status", methods=['GET', 'POST'])
def status():
    if request.method == 'POST':
        id = request.form.get('id')
        status = request.form.get('status')

        sql = "SELECT * FROM container"
        mycursor.execute(sql)
        myresult = mycursor.fetchall()
        data = []
        for result in myresult:
            content = {'vm_id': result[1], 'status': result[2]}
            data.append(content)
        return json.dumps(data)


@app.route("/statusvm", methods=['GET', 'POST'])
def statusvm():
    if request.method == 'POST':
        id = request.form.get('id')
        status = request.form.get('status')

        sql = "SELECT * FROM machine"
        mycursor.execute(sql)
        myresult = mycursor.fetchall()
        data = []
        for result in myresult:
            content = {'vm_id': result[1], 'status': result[2]}
            data.append(content)
        return json.dumps(data)


@app.route("/memoryauto", methods=['GET', 'POST'])
def memoryauto():
    if request.method == 'POST':
        id = request.form.get('id')
        url = f'https://{ip_add}:8006/api2/json/nodes/{node_name}/qemu/{id}/status/current'
        x = requests.get(
            url, verify=False, cookies=cookie)
        result = x.json()
        a = result['data']['maxmem']
        b = result['data']['mem']

        e = a*60/100

        if (e < b):
            while a == b:
                a = a + 512
            command = f"qm set {id} --memory {a}"
            client = paramiko.client.SSHClient()
            client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
            client.connect(ip_add, username=username, password=password)
            _stdin, _stdout, _stderr = client.exec_command(command)
            return f'berhasil menambahkan memory {id}'
        else:
            return f'memory belum penuh {id}'


@app.route("/memoryautocont", methods=['GET', 'POST'])
def memoryautocont():
    if request.method == 'POST':
        id = request.form.get('id')
        url = f'https://{ip_add}:8006/api2/json/nodes/{node_name}/lxc/{id}/status/current'
        x = requests.get(
            url, verify=False, cookies=cookie)
        result = x.json()
        a = result['data']['maxmem']
        b = result['data']['mem']
        e = a*60/100
        # b= 14
        c = result['data']['swap']
        d = result['data']['maxswap']

        mem = a / 1048576
        if e < b:
            mem = int(mem + 512)
            command = f"pct set {id} --memory {mem}"
            client = paramiko.client.SSHClient()
            client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
            client.connect(ip_add, username=username, password=password)
            _stdin, _stdout, _stderr = client.exec_command(command)
            return f'total {mem}'
        else:
            return f'memory belum penuh {mem}'


@app.route("/add", methods=['GET', 'POST'])
def add():
    if request.method == 'POST':
        id = request.form.get('id')
        status = request.form.get('status')

        sql = "INSERT INTO machine (vm_id, status) VALUES (%s,%s)"
        val = (id, status)
        mycursor.execute(sql, val)
        mydb.commit()

        return 'oke'


@app.route("/addcontainer", methods=['GET', 'POST'])
def addcontainer():
    if request.method == 'POST':
        id = request.form.get('id')
        status = request.form.get('status')

        sql = "INSERT INTO container (cont_id, status) VALUES (%s,%s)"
        val = (id, status)
        mycursor.execute(sql, val)
        mydb.commit()

        return 'oke'


@app.route("/remove", methods=['GET', 'POST'])
def remove():
    if request.method == 'POST':
        id = request.form.get('id')
        sql = f'DELETE FROM machine WHERE vm_id = {id}'
        mycursor.execute(sql)
        mydb.commit()

        return 'success'


@app.route("/removecontainer", methods=['GET', 'POST'])
def removecontainer():
    if request.method == 'POST':
        id = request.form.get('id')
        sql = f'DELETE FROM container WHERE cont_id = {id}'
        mycursor.execute(sql)
        mydb.commit()

        return 'success'


@app.route("/", methods=['GET', 'POST'])
def index():
    global ip_add, cookie, node_name, username, password
    if request.method == 'GET':
        return render_template('login.html')

    if request.method == 'POST':
        ip_add = request.form['ip_address']
        username = request.form['username']
        password = request.form['password']
        url = f'https://{ip_add}:8006/api2/json/access/ticket?username={username}@pam&password={password}'

        x = requests.post(
            url, verify=False)
        result = x.json()
        cookie = {"PVEAuthCookie": result['data']
                  ['ticket'], "Path": '/', "Domain": ip_add}

        get_node = f"https://{ip_add}:8006/api2/json/nodes"
        node = requests.get(get_node, verify=False, cookies=cookie).json()
        node_name = node["data"][0]["node"]

        url = f'https://{ip_add}:8006/api2/json/nodes/{node_name}/qemu'
        x = requests.get(
            url, verify=False, cookies=cookie)
        result = x.json()
        for x in range(len(result['data'])):
            result['data'][x]['mem'] = round(
                result['data'][x]['mem'] / 1073741824, 2)

    return render_template('lib/pages/host/host_info_page.dart',data=result)


@app.route("/container", methods=['GET'])
def container():

    url = f'https://{ip_add}:8006/api2/json/nodes/{node_name}/lxc'
    x = requests.get(
        url, verify=False, cookies=cookie)
    result = x.json()
    for x in range(len(result['data'])):
        result['data'][x]['disk'] = round(
            result['data'][x]['disk'] / 1073741824, 2)
        result['data'][x]['mem'] = round(
            result['data'][x]['mem'] / 1073741824, 2)
    return render_template('container.html', data=result)


@app.route("/vm", methods=['GET'])
def vm():

    url = f'https://{ip_add}:8006/api2/json/nodes/{node_name}/qemu'
    x = requests.get(
        url, verify=False, cookies=cookie)
    result = x.json()
    for x in range(len(result['data'])):
        result['data'][x]['mem'] = round(
            result['data'][x]['mem'] / 1073741824, 2)
    # print(result)
    return render_template('index.html', data=result)


@app.route("/virtualmachines/<int:id>")
def virtualmachines(id):
    url = f'https://{ip_add}:8006/api2/json/nodes/{node_name}/qemu/{id}/status/current'
    x = requests.get(
        url, verify=False, cookies=cookie)
    result = x.json()
    result['data']['mem'] = round(result['data']['mem'] / 1073741824, 2)
    result['data']['maxmem'] = round(result['data']['maxmem'] / 1073741824, 2)
    # print(result['data']['mem'])
    return render_template('virtualmachines.html', data=result)


@app.route("/containerview/<int:id>")
def containerview(id):
    url = f'https://{ip_add}:8006/api2/json/nodes/{node_name}/lxc/{id}/status/current'
    x = requests.get(
        url, verify=False, cookies=cookie)
    result = x.json()
    result['data']['mem'] = round(result['data']['mem'] / 1073741824, 2)
    result['data']['maxmem'] = round(result['data']['maxmem'] / 1073741824, 2)
    result['data']['disk'] = round(result['data']['disk'] / 1073741824, 2)
    result['data']['maxdisk'] = round(
        result['data']['maxdisk'] / 1073741824, 2)
    return render_template('containerview.html', data=result)


@app.route("/editmem/<int:id>", methods=['GET', 'POST'])
def editmem(id):
    if request.method == 'GET':
        return render_template('editmem.html', data=id)


@app.route("/editmemvm", methods=['GET', 'POST'])
def editmemvm():
    if request.method == 'POST':
        memory = request.form['memory']
        id = request.form.get('id')
        command = f"qm set {id} --memory {memory}"
        client = paramiko.client.SSHClient()
        client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        client.connect(ip_add, username=username, password=password)
        _stdin, _stdout, _stderr = client.exec_command(command)
        data = {
            "id": id,
            "cpu": memory,
        }
        return json.dumps(data)


@app.route("/editmemcontainer/<int:id>", methods=['GET', 'POST'])
def editmemcontainer(id):
    if request.method == 'GET':
        return render_template('editmemcont.html', data=id)


@app.route("/editmemcont", methods=['GET', 'POST'])
def editmemcont():
    if request.method == 'POST':
        memory = request.form['memory']
        id = request.form.get('id')
        command = f"pct set {id} --memory {memory}"
        client = paramiko.client.SSHClient()
        client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        client.connect(ip_add, username=username, password=password)
        _stdin, _stdout, _stderr = client.exec_command(command)
        data = {
            "id": id,
            "memory": memory,
        }
        return json.dumps(data)


@app.route("/editcpucontainerview/<int:id>", methods=['GET', 'POST'])
def editcpucontainerview(id):
    if request.method == 'GET':
        url = f'https://{ip_add}:8006/api2/json/nodes/{node_name}/lxc/{id}/status/current'
        x = requests.get(
            url, verify=False, cookies=cookie)
        result = x.json()
        return render_template('editcpucont.html', data=result)


@app.route("/edithddcontainerview/<int:id>", methods=['GET', 'POST'])
def edithddcontainerview(id):
    if request.method == 'GET':
        url = f'https://{ip_add}:8006/api2/json/nodes/{node_name}/lxc/{id}/status/current'
        x = requests.get(
            url, verify=False, cookies=cookie)
        result = x.json()
        result['data']['maxdisk'] = round(
            result['data']['maxdisk'] / 1073741824, 2)
        return render_template('editdiskcont.html', data=result)


@app.route("/editcpucontainer", methods=['GET', 'POST'])
def editcpucontainer():
    if request.method == 'POST':
        id = request.form.get('id')
        cpu = request.form.get('cpu')
        command = f"pct set {id} --core {cpu}"
        client = paramiko.client.SSHClient()
        client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        client.connect(ip_add, username=username, password=password)
        _stdin, _stdout, _stderr = client.exec_command(command)
        data = {
            "id": id,
            "cpu": cpu,
        }
        return json.dumps(data)


@app.route("/edithddcontainer", methods=['GET', 'POST'])
def edithddcontainer():
    if request.method == 'POST':
        id = request.form.get('id')
        hdd = request.form.get('hdd')
        command = f"pct resize {id} rootfs +{hdd}G"
        client = paramiko.client.SSHClient()
        client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        client.connect(ip_add, username=username, password=password)
        _stdin, _stdout, _stderr = client.exec_command(command)
        data = {
            "id": id,
            "hdd": hdd,
        }
        return json.dumps(data)


@app.route("/editdisk/<int:id>", methods=['GET', 'POST'])
def editdisk(id):
    if request.method == 'POST':
        disk = request.form['disk']
        command = f"qm resize {id} scsi0 +{disk}G"
        client = paramiko.client.SSHClient()
        client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        client.connect(ip_add, username=username, password=password)
        _stdin, _stdout, _stderr = client.exec_command(command)
        return render_template('editdisk.html', data=id)

    if request.method == 'GET':
        return render_template('editdisk.html', data=id)


@app.route("/editdiskvm", methods=['GET', 'POST'])
def editdiskvm():
    if request.method == 'POST':
        disk = request.form.get('disk')
        id = request.form.get('id')
        command = f"qm resize {id} scsi0 +{disk}G"
        client = paramiko.client.SSHClient()
        client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        client.connect(ip_add, username=username, password=password)
        _stdin, _stdout, _stderr = client.exec_command(command)
        data = {
            "id": id,
            "cpu": disk,
        }
        return json.dumps(data)


@app.route("/editcpu/<int:id>", methods=['GET', 'POST'])
def editcpu(id):
    url = f'https://{ip_add}:8006/api2/json/nodes/{node_name}/qemu/{id}/status/current'
    x = requests.get(
        url, verify=False, cookies=cookie)
    result = x.json()
    if request.method == 'POST':
        cpu = request.form.get['cpu']
        command = f"qm set {id} --core {cpu}"
        client = paramiko.client.SSHClient()
        client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        client.connect(ip_add, username=username, password=password)
        _stdin, _stdout, _stderr = client.exec_command(command)
        return render_template('editcpu.html', data=result)

    if request.method == 'GET':
        return render_template('editcpu.html', data=result)


@app.route("/editcpuvm", methods=['GET', 'POST'])
def editcpuvm():
    if request.method == 'POST':
        cpu = request.form.get('cpu')
        id = request.form.get('id')
        command = f"qm set {id} --core {cpu}"
        client = paramiko.client.SSHClient()
        client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        client.connect(ip_add, username=username, password=password)
        _stdin, _stdout, _stderr = client.exec_command(command)
        data = {
            "id": id,
            "cpu": cpu,
        }
        return json.dumps(data)


@app.route("/memauto/<int:id>", methods=['GET', 'POST'])
def memauto(id):
    if request.method == 'POST':
        memory = request.form['memory']
        a = {{memory['data']['maxmem']}}
        b = {{memory['data']['mem']}}
        while a == b:
            a = a + 512
        command = f"qm set {id} --memory {a}"
        client = paramiko.client.SSHClient()
        client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        client.connect(ip_add, username=username, password=password)
        _stdin, _stdout, _stderr = client.exec_command(command)
        return render_template('editmem.html', data=id)

    if request.method == 'GET':
        return render_template('editmem.html', data=id)


if __name__ == '__main__':
    app.run(debug=True)

# paramiko menjalankan fungsi updateMem di background: cron tab

def get_used_memory():
    mem_info = psutil.virtual_memory()
    used_memory = mem_info.used / (1024 ** 3)  # Mengkonversi ke gigabytes (GB)
    return used_memory

# Menggunakan fungsi get_used_memory()
used_mem = get_used_memory()
print("Memori terpakai saat ini:", used_mem, "GB")

def get_max_memory(max_mem):
    max_mem_given = 16.0
    max_mem = get_max_memory(max_mem_given)
    return max_mem

# Menggunakan fungsi get_max_memory()
# print("Memori maksimum yang diberikan:", max_mem)



def updateMem():
    existing_mem = get_used_memory()
    max_mem = get_max_memory()
    # bagaimana mengupdate memori maksimum

    if max_mem - existing_mem <= 0.2:
        command = f"qm set {id} --memory {max_mem + 1}"
        client = paramiko.client.SSHClient()
        client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        client.connect(ip_add, username=username, password=password)
        _stdin, _stdout, _stderr = client.exec_command(command)
