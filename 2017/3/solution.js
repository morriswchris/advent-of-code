// Need to build our matrix given input: currently 265149
// this will produce:
/*
37  36  35  34  33  32  31
38  17  16  15  14  13  30
39  18   5   4   3  12  29
40  19   6   1   2  11  28
41  20   7   8   9  10  27
42  21  22  23  24  25  26
43  44  45  46  47  48  49
*/

// if square is odd,   1 is at position [ceil(x/2), ceil(y/2)
// if square is event, 1 is at position [x/2], (x/2)+1

// if square is odd, 

// our matrix is 6*6, which is the last digit in our sequence (36)
// let dataSquare = 26;

// // calculate the closest square
// let closestSquare = Math.ceil(Math.sqrt(dataSquare))**2

// // get square root to how long our x/y are
// let square = Math.sqrt(closestSquare);

// // calculate where our number falls (middle means go up)
// let middle = square/2
// let middleNumber = Math.round(closestSquare - middle)

// // calculate how far on the x axis our number is
// middleNumber > dataSquare




let dataSquare = 16;
let closestSquare = Math.ceil(Math.sqrt(dataSquare))**2;
let square = Math.sqrt(closestSquare);
var matrix = Array.from(new Array(square), (x,i) => Array.from(new Array(square), (x,i) => i*2));
let x1 = Math.ceil(square/2);
let y1 = square%2 < 1 ? (square/2)+1 : x1;
var values = Array.from(new Array(closestSquare), (x, i) => closestSquare-i);

var chuncks = values.reduce((a,b,i,g) => !(i % square) ? a.concat([g.slice(i,(i < 1 ? i+square : i+square-1))]) : a, []);
console.log(chuncks);

//  1. draw matrix
// 2. determine x, y pairings 
// 3. subtract xs, and ys, sum the differences



// values.map(val => {
//     if (val > 12) {
//         console.log(closestSquare, val);
//         matrix[0].splice(closestSquare-val, 1, val);
//         console.log(matrix);
//     }

// });




