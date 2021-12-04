package main

import (
    "bufio"
    "fmt"
    "log"
    "os"
		"strconv"
)

type Measurements struct {
	lastValue int
	totalIncreases int
}

func main() {
    file, err := os.Open("./input.txt")
    if err != nil {
        log.Fatal(err)
    }
    defer file.Close()

		// Initialize to -1 to account for setting the lastValue being lower than the current
		measurements := Measurements{totalIncreases: -1, lastValue: -1}
    scanner := bufio.NewScanner(file)
    for scanner.Scan() {
			currentValue, _ := strconv.Atoi(scanner.Text())
			
			 measurementValue := measurements.lastValue
			if measurementValue < currentValue {
				measurements.totalIncreases++
			}
			measurements.lastValue = currentValue
    }

    if err := scanner.Err(); err != nil {
      log.Fatal(err)
    }
		fmt.Printf("totalIncreases: %d",  measurements.totalIncreases)
}
