/* global $*/
/* global trim $*/

var weight = [] ;
var bodyfatPer = [] ;
var date = []; 

weight, bodyfatPer, date =  getUserRecord('week') ;
var wmax = weight.max + 10;
 
var weekChart = document.getElementById("week-chart");
new Chart(weekChart, {
    type: 'line', 
    data: {
      labels: date.to_json.html_safe,
      datasets: [
      {
          label: '体重',
          data: weight,
          borderColor: '#FF6384',
          fill:false,
      },
      {
          label: '体脂肪率',
          data: bodyfatPer,
          borderColor: "rgb(75, 192, 192)",
          fill:false,
      },
      ],
    },
    options: {
      scales: {
        xAxes: [{
          time: {
            unit: 'month'
          }
        }],
        yAxes: [{
            id: "y-axis-1",   // Y軸のID
            position: "left", // どちら側に表示される軸か？          
            ticks: {          // スケール
                max: wmax,
            },
        }],             
        }
    }
  });
  
  weight, bodyfatPer, date =  getUserRecord('month') ;
  var monthChart = document.getElementById("month-chart");
  new Chart(monthChart, {
    type: 'line', 
    data: {
      labels: date.to_json.html_safe,
      datasets: [
      {
          label: '体重',
          data: weight,
          borderColor: '#FF6384',
          fill:false,
      },
      {
          label: '体脂肪率',
          data: bodyfatPer,
          borderColor: "rgb(75, 192, 192)",
          fill:false,
      },
      ],
    },
    options: {
      scales: {
        xAxes: [{
          time: {
            unit: 'month'
          }
        }],
        yAxes: [{
            id: "y-axis-1",   // Y軸のID
            position: "left", // どちら側に表示される軸か？          
            ticks: {          // スケール
                max: wmax,
            },
        }],             
        }
    }
  });  
  weight, bodyfatPer, date =  getUserRecord('three_month');
  var month3Chart = document.getElementById("month3-chart");
  new Chart(month3Chart, {
    type: 'line', 
    data: {
      labels: date.to_json.html_safe,
      datasets: [
      {
          label: '体重',
          data: weight,
          borderColor: '#FF6384',
          fill:false,
      },
      {
          label: '体脂肪率',
          data: bodyfatPer,
          borderColor: "rgb(75, 192, 192)",
          fill:false,
      },
      ],
    },
    options: {
      scales: {
        xAxes: [{
          time: {
            unit: 'month'
          }
        }],
        yAxes: [{
            id: "y-axis-1",   // Y軸のID
            position: "left", // どちら側に表示される軸か？          
            ticks: {          // スケール
                max: wmax,
            },
        }],             
        }
    }
  });  
  weight, bodyfatPer, date =  getUserRecord('six_month');
  var month6Chart = document.getElementById("month6-chart");
  new Chart(month6Chart, {
    type: 'line', 
    data: {
      labels: date.to_json.html_safe,
      datasets: [
      {
          label: '体重',
          data: weight,
          borderColor: '#FF6384',
          fill:false,
      },
      {
          label: '体脂肪率',
          data: bodyfatPer,
          borderColor: "rgb(75, 192, 192)",
          fill:false,
      },
      ],
    },
    options: {
      scales: {
        xAxes: [{
          time: {
            unit: 'month'
          }
        }],
        yAxes: [{
            id: "y-axis-1",   // Y軸のID
            position: "left", // どちら側に表示される軸か？          
            ticks: {          // スケール
                max: wmax,
            },
        }],             
        }
    }
  });