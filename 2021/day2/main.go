package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"strconv"
	"strings"
)

type Measurements struct {
	horizontal int
	depth int
	depthAim int
}

type Command struct {
	direction string
	amount int
}

func main() {
	file, err := os.Open("./input.txt")
	if err != nil {
		log.Fatal(err)
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)
	measurements := Measurements{horizontal: 0, depth: 0, depthAim: 0}
	for scanner.Scan() {
		command := commandDirections(scanner.Text())

		switch command.direction {
		case "forward":
			measurements.horizontal += command.amount
			measurements.depthAim += command.amount * measurements.depth
		case "down":
			measurements.depth += command.amount
		case "up":
			measurements.depth -= command.amount
		}
	}

	if err := scanner.Err(); err != nil {
		log.Fatal(err)
	}
	position := measurements.horizontal * measurements.depth
	positionAim := measurements.horizontal * measurements.depthAim
	fmt.Printf("total position: %d",  position)
	fmt.Printf("total position with aim: %d",  positionAim)
}

func commandDirections(command string) Command {
	commandSplit := strings.Split(command, " ")
	amount, _ := strconv.Atoi(commandSplit[1])
	return Command{direction: commandSplit[0], amount: amount}
}
