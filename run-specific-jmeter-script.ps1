param (
    [string]$ScriptName = "example.jmx"
)

# Resolve volume paths
$volume_path = (Join-Path (Get-Location) "jmeter-scripts")
$jmeter_path = "/mnt/jmeter"

# Ensure results folder exists
$resultsFolder = Join-Path $volume_path "results"
if (-not (Test-Path $resultsFolder)) {
    New-Item -ItemType Directory -Path $resultsFolder | Out-Null
}

# Run Docker container with JMeter
# Mounts a local folder into the Docker container:$volume_pat to $jmeter_path 
# sh -c "..."
# Tells Docker to run a shell command inside the container.
docker run `
    --rm `
    -v "${volume_path}:${jmeter_path}" `
    jmeter `
    sh -c "jmeter -n -t ${jmeter_path}/${ScriptName} -JINFLUXDB_HOST=host.docker.internal -l ${jmeter_path}/results/result.jtl -j ${jmeter_path}/results/jmeter.log"
