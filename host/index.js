const express = require("express")
const app = express()

const { exec } = require("child_process")
const IP = '127.0.0.1'

const print = console.log

const getJSONbatteryInfo = () => {
	
}

app.get("/", (req, res) => {
	
	exec("upower -i $(upower -e | grep BAT)", (err, stdout, stderr) => {
		if (err) {
			return undefined
		}
		var output = {}
        var lines = stdout.split('\n')
        for (let i = 0; i < lines.length; i++) {
            let line = lines[i]
            if (line.trim() != "battery") {
				let currentLine = line.split(':')
				if (currentLine[0] != undefined && currentLine[1] != undefined) {
					output[currentLine[0].trim()] = currentLine[1].trim()
				}
			}
        }
        
        res.set("Content-Type", "application/json")
        
        print(output)
        res.json(output)
	})
})

app.listen(8080)
