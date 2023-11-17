Widget.Box({ // Weather
       vpack: 'center',
       className: 'spacing-h-5',
       children: [
       Widget.Label({
       className: 'bar-clock',
       connections: [[5000, label => {
       execAsync([`/home/nonan23x/.scripts/weather.sh`]).then(timeString => {
       label.label = timeString;
       }).catch(print);
       }]],
       }),
       ],
})
