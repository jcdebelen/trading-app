import Highcharts from "highcharts/highstock";

(async () => {
  const data = await fetch(
    "https://demo-live-data.highcharts.com/aapl-ohlcv.json"
  ).then((r) => r.json());
  Highcharts.stockChart("container", {
    rangeSelector: {
      selected: 1,
    },

    title: {
      text: "",
    },

    series: [
      {
        data: data,
        tooltip: {
          valueDecimals: 2,
        },
      },
    ],
  });
})();
