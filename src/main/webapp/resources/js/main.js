
function drawChart(chartDiv, title, dataList) {
	google.charts.load("current", { packages: ["corechart"] });
	google.charts.setOnLoadCallback(drawChart);
	function drawChart() {
		var data = google.visualization.arrayToDataTable([
			["date", "total_sales", { role: "style" }],
			[dataList[0].label, dataList[0].value, "#b87333"],
			[dataList[1].label, dataList[1].value, "silver"],
			[dataList[2].label, dataList[2].value, "gold"],
			[dataList[3].label, dataList[3].value, "color: #e5e4e2"],
			[dataList[4].label, dataList[4].value, "color: #ccc"]
		]);

		var view = new google.visualization.DataView(data);
		view.setColumns([0, 1,
			{
				calc: "stringify",
				sourceColumn: 1,
				type: "string",
				role: "annotation"
			},
			2]);

		var options = {
			title: title,
			width: 600,
			height: 400,
			bar: { groupWidth: "95%" },
			legend: { position: "none" },
			backgroundColor: '#f1f1f1'
		};
		var chart = new google.visualization.BarChart(document.getElementById(chartDiv));
		chart.draw(view, options);

	}
}

function drawPieChart(chartDiv, title, dataList) {
	google.charts.load('current', { 'packages': ['corechart'] });
	google.charts.setOnLoadCallback(drawChart);

	function drawChart() {

		var dataArray = new Array();
		dataArray.push(['date', 'count']);
		for (let i = 0; i < dataList.length; i++) {
			dataArray.push([dataList[i].reason, dataList[i].count]);
		}
		
		var data = google.visualization.arrayToDataTable(dataArray);

		var options = {
			title: title,
			width: 600,
			height: 600,
			backgroundColor: '#f1f1f1'
		};

		var chart = new google.visualization.PieChart(document.getElementById(chartDiv));

		chart.draw(data, options);
	}
}

function drawScatterChart(chartDiv, title, dataList) {
	 google.charts.load('current', {'packages':['corechart']});
     google.charts.setOnLoadCallback(drawChart);

	var dataArray = new Array();
	dataArray.push(['date', '접속수']);
	for (let i = dataList.length - 1; i >= 0; i--) {
		let date = dataList[i].start_date + "~" + dataList[i].end_date;
		dataArray.push([date, dataList[i].visit]);
	}

	function drawChart() {
		var data = google.visualization.arrayToDataTable(dataArray);

		var options = {
			title: title,
			width: 575,
			height: 600,
			hAxis: {title: 'week',  titleTextStyle: {color: '#333'}},
			vAxis: {minValue: 0},
			backgroundColor: '#f1f1f1'
		};

		var chart = new google.visualization.AreaChart(document.getElementById(chartDiv));

		chart.draw(data, options);
	}
}

