
# 📊 JMeter + InfluxDB + Grafana Docker Container

This container setup allows you to instantly sync **JMeter** results with **InfluxDB** and visualize test results in **Grafana** in real time.

---


## ✅ Prerequisites

Ensure the following tools are installed on your machine:

* Docker
* Docker Compose

---

## 🏗️ Build JMeter Docker Image

```bash
docker build -t jmeter jmeter-docker
```

---

## ▶️ Start InfluxDB and Grafana

```bash
docker-compose up -d
```

---

## 🔧 Adjust JMeter Script

Define the following **2 variables** in the **Test Plan component** of your JMeter script:(Just an example of where you can set variables — the current .jmx script already has them defined.)

| Name            | Value                              |
| --------------- | ---------------------------------- |
| `CLIENTNAME`    | `Example`                          |
| `STARTDATETIME` | `${__time(yy-MM-dd-HH:mm:ss:SSS)}` |

![JMeter Variables](<Jmeter varibale.png>)

---

### ➕ Add & Configure Backend Listener in JMeter (Just an example of where you can set variables — the current .jmx script already has them defined.)

![JMeter Backend Listener](docs/images/BackendListener.png)

#### Explanation:

```properties
${__P(INFLUXDB_HOST, localhost)}
```

* Uses the value of `INFLUXDB_HOST` **if provided** when launching JMeter.
* Defaults to `localhost` otherwise.

**Resulting URL:**

```
http://localhost:8086/write?db=jmeter_results
```

---

## ⚙️ Backend Listener Configuration Parameters

| Name                    | Value                                                                  |
| ----------------------- | ---------------------------------------------------------------------- |
| `influxdbMetricsSender` | `org.apache.jmeter.visualizers.backend.influxdb.HttpMetricsSender`     |
| `influxdbUrl`           | `http://${__P(INFLUXDB_HOST, localhost)}:8086/write?db=jmeter_results` |
| `application`           | `${CLIENTNAME}_${STARTDATETIME}`                                       |
| `measurement`           | `jmeter`                                                               |
| `summaryOnly`           | `false`                                                                |
| `samplersRegex`         | `.*`                                                                   |
| `percentiles`           | `90;95;99`                                                             |
| `testTitle`             | `Test name`                                                            |
| `eventTags`             | *(leave blank or define tags)*                                         |

---

## 🖥️ Run JMeter Script on macOS/Linux

```bash
./run-specific-jmeter-script.sh example.jmx
```

---

## 🪟 Run JMeter Script on Windows

```bash
.\run-specific-jmeter-script.ps1 example.jmx
```


## 📈 Grafana Dashboard

Open: [http://localhost:3000/dashboards](http://localhost:3000/dashboards) 
Then click "JMeter Dashboard"

![Grafana Dashboard](docs/images/Grafana.png)

## 🛢️ InfluxDB

![InfluxDB](docs/images/InfuxDB.png)

---


---

## 📑 Generate JMeter HTML Report

```bash
jmeter -g jmeter-scripts/results/result.jtl -o jmeter-scripts/results/report
```
![alt text](<Basic Report.png>)

---

## 🎛️ Filter the Correct Test Run in Grafana

It is the **concatenation** of:

```
CLIENTNAME + STARTDATETIME
```

![Grafana Filter](docs/images/Grafana_filter.png)

---

## 📚 Disclaimer

> Inspired by: [BlazeMeter blog - Make Use of Docker with JMeter](https://www.blazemeter.com/blog/make-use-of-docker-with-jmeter-learn-how)

---

## 💖 Support This Project

If you find this project helpful and want to support further development, please consider [supporting](https://testwithroy.com/b/support) it.

> Thank you for your support!

---

Let me know if you want to include YAML for `docker-compose.yml` or `taurus.yml` as well!
