// Plot the default route once the page loads
var defaultURL = "/emoji_char";
d3.json(defaultURL).then(function(data) {
  var data = [data];
  var layout = { title: "Bellybutton pie chart", height: 600, width: 800 };
  Plotly.plot("bar", data, layout);
  });

// Update the plot with new data
function updatePlotly(newdata) {
// Plotly.restyle(PIE, "labels", "values", [newdata]);
//   // Plotly.restyle(PIE, "values", [newdata.values]);
  Plotly.restyle("bar", "labels", [newdata.labels]);
  Plotly.restyle("bar", "values", [newdata.values]);
// }

// JB: use pie get data
// function updatePlotly(newdata) {
//   var PIE = document.getElementById("pie");
//   Plotly.restyle(PIE, "values", [newdata]);
// }

// Get new data whenever the dropdown selection changes
function getData(route) {
  console.log(route);
  d3.json(`/${route}`).then(function(data) {
    console.log("newdata", data);
    updatePlotly(data);
  });
}
