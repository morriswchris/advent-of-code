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
	slidingWindow map[int][]int
	totalPathIncreases int
}

func main() {
    file, err := os.Open("./input.txt")
    if err != nil {
        log.Fatal(err)
    }
    defer file.Close()

		// Initialize to -1 to account for setting the lastValue being lower than the current
		measurements := Measurements{totalIncreases: -1, lastValue: -1, totalPathIncreases: 0, slidingWindow: map[int][]int{
			0: []int{},
			1: []int{},
			2: []int{},
			3: []int{},
		}}
    scanner := bufio.NewScanner(file)
    for scanner.Scan() {
			currentValue, _ := strconv.Atoi(scanner.Text())
			
			// Part 1
			measurementValue := measurements.lastValue
			if measurementValue < currentValue {
				measurements.totalIncreases++
			}
			measurements.lastValue = currentValue

			// Part 2
			if len(measurements.slidingWindow[0]) == 0 {
				measurements.slidingWindow[0] = append(measurements.slidingWindow[0], currentValue)
			} else if len(measurements.slidingWindow[0]) == 1 {
				measurements.slidingWindow[0] = append(measurements.slidingWindow[0], currentValue)
				measurements.slidingWindow[1] = append(measurements.slidingWindow[1], currentValue)
			} else if len(measurements.slidingWindow[0]) == 2 {
				measurements.slidingWindow[0] = append(measurements.slidingWindow[0], currentValue)
				measurements.slidingWindow[1] = append(measurements.slidingWindow[1], currentValue)
				measurements.slidingWindow[2] = append(measurements.slidingWindow[2], currentValue)
			} else if len(measurements.slidingWindow[0]) == 3 {
				measurements.slidingWindow[1] = append(measurements.slidingWindow[1], currentValue)
				measurements.slidingWindow[2] = append(measurements.slidingWindow[2], currentValue)
				measurements.slidingWindow[3] = append(measurements.slidingWindow[3], currentValue)
			}

			if len(measurements.slidingWindow[0]) == 3 && len(measurements.slidingWindow[1]) == 3 {
				sumPrevious := addArray(measurements.slidingWindow[0]...) 
				sumCurrent := addArray(measurements.slidingWindow[1]...)
				if sumPrevious < sumCurrent {
					measurements.totalPathIncreases++
				}

				// reset the window
				measurements.slidingWindow[0] = measurements.slidingWindow[1]
				measurements.slidingWindow[1] = measurements.slidingWindow[2]
				measurements.slidingWindow[2] = measurements.slidingWindow[3]
				measurements.slidingWindow[3] = []int{}
			}
    }

    if err := scanner.Err(); err != nil {
      log.Fatal(err)
    }
		fmt.Printf("totalIncreases: %d",  measurements.totalIncreases)
		fmt.Printf(" totalPathIncreases: %d",  measurements.totalPathIncreases)
}

func addArray(numbs ...int) int {  
 result := 0  
 for _, numb := range numbs {  
  result += numb  
 }  
 return result  
}  

