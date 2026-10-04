/**
 * CodeRush - Data Visualization & Performance Charting Suite
 */

document.addEventListener('DOMContentLoaded', () => {
    // 1. History Trend Chart
    const historyCanvas = document.getElementById('historyTrendChart');
    if (historyCanvas && typeof Chart !== 'undefined') {
        const rows = document.querySelectorAll('#history-table-body tr');
        const labels = [];
        const wpmData = [];
        const accuracyData = [];

        // Parse up to last 15 attempts in reverse chronological order
        const dataRows = Array.from(rows).slice(0, 15).reverse();

        dataRows.forEach((row, idx) => {
            const dateCell = row.querySelector('.col-date');
            const wpmCell = row.querySelector('.col-wpm');
            const accCell = row.querySelector('.col-acc');

            if (wpmCell && accCell) {
                const dateText = dateCell ? dateCell.textContent.trim().split(' ')[0] : `#${idx + 1}`;
                labels.push(dateText);
                wpmData.push(parseFloat(wpmCell.textContent.trim()) || 0);
                accuracyData.push(parseFloat(accCell.textContent.trim().replace('%', '')) || 0);
            }
        });

        if (labels.length > 0) {
            new Chart(historyCanvas, {
                type: 'line',
                data: {
                    labels: labels,
                    datasets: [
                        {
                            label: 'Speed (WPM)',
                            data: wpmData,
                            borderColor: '#38bdf8',
                            backgroundColor: 'rgba(56, 189, 248, 0.1)',
                            borderWidth: 3,
                            pointBackgroundColor: '#38bdf8',
                            pointRadius: 4,
                            tension: 0.35,
                            fill: true,
                            yAxisID: 'y'
                        },
                        {
                            label: 'Accuracy (%)',
                            data: accuracyData,
                            borderColor: '#22c55e',
                            backgroundColor: 'transparent',
                            borderWidth: 2,
                            borderDash: [5, 5],
                            pointBackgroundColor: '#22c55e',
                            pointRadius: 3,
                            tension: 0.3,
                            yAxisID: 'y1'
                        }
                    ]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    interaction: {
                        mode: 'index',
                        intersect: false
                    },
                    plugins: {
                        legend: {
                            labels: {
                                color: '#94a3b8',
                                font: { family: 'Inter', size: 12, weight: '600' }
                            }
                        }
                    },
                    scales: {
                        x: {
                            grid: { color: 'rgba(255, 255, 255, 0.05)' },
                            ticks: { color: '#64748b' }
                        },
                        y: {
                            type: 'linear',
                            display: true,
                            position: 'left',
                            title: { display: true, text: 'WPM', color: '#38bdf8' },
                            grid: { color: 'rgba(255, 255, 255, 0.05)' },
                            ticks: { color: '#94a3b8' }
                        },
                        y1: {
                            type: 'linear',
                            display: true,
                            position: 'right',
                            min: 0,
                            max: 100,
                            title: { display: true, text: 'Accuracy %', color: '#22c55e' },
                            grid: { drawOnChartArea: false },
                            ticks: { color: '#94a3b8' }
                        }
                    }
                }
            });
        }
    }
});
