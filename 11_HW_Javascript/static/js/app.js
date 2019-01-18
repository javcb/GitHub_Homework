// // from data.js
// var ufo = data;

// // YOUR CODE HERE!

// // Select the submit button
// var submit = d3.select("#filter-btn");

// submit.on("click", function() {

//   // Prevent the page from refreshing
//   d3.event.preventDefault();

//   // Select the input element and get the raw HTML node
//   var inputElement = d3.select("#datetime");

//   // Get the value property of the input element
//   var inputValue = inputElement.property("value");

//   console.log(inputValue);
//   console.log(ufo);

//   var filteredData = ufo.filter(sightings => sightings.datetime === inputValue);

//   console.log(filteredData);

//_____________________________________________________________________________

//JB: method from JS class 3, exercise 03 Evr D3 Table
var tbody = d3.select("tbody");

//JB: add filter:
var ufo = data;
var submit = d3.select("#filter-btn");
submit.on("click", function() {

d3.event.preventDefault();
    
var inputElement = d3.select("#datetime");

var inputValue = inputElement.property("value");

console.log(inputValue);
console.log(ufo);

var filteredData = ufo.filter(sightings => sightings.datetime === inputValue);

console.log(filteredData);

    filteredData.forEach((sighting) => {
        var row = tbody.append("tr");
        Object.entries(sighting).forEach(([key, value]) => {
          var cell = tbody.append("td");
          cell.text(value);
        });
});

// BONUS: Refactor to use Arrow Functions!
// data.forEach((sighting) => {
//     var row = tbody.append("tr");
//     Object.entries(sighting).forEach(([key, value]) => {
//       var cell = tbody.append("td");
//       cell.text(value);
//     });    

        
// Console.log the weather data from data.js
//console.log(data);

// // Step 1: Loop Through `data` and console.log each weather report object
// data.forEach(function(weatherReport) {
//   console.log(weatherReport);
// });

// // Step 2:  Use d3 to append one table row `tr` for each weather report object
// // Don't worry about adding cells or text yet, just try appending the `tr` elements.
// data.forEach(function(weatherReport) {
//   console.log(weatherReport);
//   var row = tbody.append("tr");
// });

// // Step 3:  Use `Object.entries` to console.log each weather report value
// data.forEach(function(weatherReport) {
//   console.log(weatherReport);
//   var row = tbody.append("tr");

//   Object.entries(weatherReport).forEach(function([key, value]) {
//     console.log(key, value);
//   });
// });

// // Step 4: Use d3 to append 1 cell per weather report value (weekday, date, high, low)
// data.forEach(function(weatherReport) {
//   console.log(weatherReport);
//   var row = tbody.append("tr");

//   Object.entries(weatherReport).forEach(function([key, value]) {
//     console.log(key, value);
//     // Append a cell to the row for each value
//     // in the weather report object
//     var cell = tbody.append("td");
//   });
// });

// // Step 5: Use d3 to update each cell's text with
// // weather report values (weekday, date, high, low)
// data.forEach(function(weatherReport) {
//   console.log(weatherReport);
//   var row = tbody.append("tr");
//   Object.entries(weatherReport).forEach(function([key, value]) {
//     console.log(key, value);
//     // Append a cell to the row for each value
//     // in the weather report object
//     var cell = tbody.append("td");
//     cell.text(value);
//   });

// // BONUS: Refactor to use Arrow Functions!
// data.forEach((sighting) => {
//     var row = tbody.append("tr");
//     Object.entries(sighting).forEach(([key, value]) => {
//       var cell = tbody.append("td");
//       cell.text(value);
//     });

//_____________________________________________________________________________  
// //JB: Starting adding data here...
//   var datetime = filteredData.map(sightings => sightings.datetime)
//   var city = filteredData.map(sightings => sightings.city)
//   var state = filteredData.map(sightings => sightings.state)
//   var country = filteredData.map(sightings => sightings.country)
//   var shape = filteredData.map(sightings => sightings.shape)
//   var durationMinutes = filteredData.map(sightings => sightings.durationMinutes)
//   var comments = filteredData.map(sightings => sightings.comments)

//   d3.select(".summary")
//   .append("li").text(`Date: ${datetime}`)
//   .append("li").text(`City: ${city}`)
//   .append("li").text(`State: ${state}`)
//   .append("li").text(`Country: ${country}`)
//   .append("li").text(`Shape: ${shape}`)
//   .append("li").text(`Duration: ${durationMinutes}`)
//   .append("li").text(`Comments: ${comments}`);

  
//_____________________________________________________________________________

//   // BONUS: Calculate summary statistics for the age field of the filtered data

//   // First, create an array with just the age values
//   var ages = filteredData.map(sightings => sightings.age);

//   // Next, use math.js to calculate the mean, median, mode, var, and std of the ages
//   var mean = math.mean(ages);
//   var median = math.median(ages);
//   var mode = math.mode(ages);
//   var variance = math.var(ages);
//   var standardDeviation = math.std(ages);

//   // Finally, add the summary stats to the `ul` tag
//   d3.select(".summary")
//     .append("li").text(`Mean: ${mean}`)
//     .append("li").text(`Median: ${median}`)
//     .append("li").text(`Mode: ${mode}`)
//     .append("li").text(`Variance: ${variance}`)
//     .append("li").text(`Standard Deviation: ${standardDeviation}`);
//_____________________________________________________________________________

});
