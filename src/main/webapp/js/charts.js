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
                            borderColor: '#5E6AD2',
                            backgroundColor: 'rgba(94, 106, 210, 0.08)',
                            borderWidth: 2.5,
                            pointBackgroundColor: '#6872D9',
                            pointBorderColor: '#0a0a0c',
                            pointBorderWidth: 2,
                            pointRadius: 4,
                            pointHoverRadius: 6,
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
                            borderDash: [6, 3],
                            pointBackgroundColor: '#4ade80',
                            pointBorderColor: '#0a0a0c',
                            pointBorderWidth: 2,
                            pointRadius: 3,
                            pointHoverRadius: 5,
                            tension: 0.3,
                            yAxisID: 'y1'
                        }
                    ]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    interaction: { mode: 'index', intersect: false },
                    plugins: {
                        legend: {
                            labels: {
                                color: '#8A8F98',
                                font: { family: 'Inter', size: 12, weight: '500' },
                                boxWidth: 12,
                                boxHeight: 12,
                                borderRadius: 3,
                                usePointStyle: true
                            }
                        },
                        tooltip: {
                            backgroundColor: 'rgba(10,10,12,0.9)',
                            borderColor: 'rgba(255,255,255,0.08)',
                            borderWidth: 1,
                            titleColor: '#EDEDEF',
                            bodyColor: '#8A8F98',
                            padding: 12,
                            cornerRadius: 8
                        }
                    },
                    scales: {
                        x: {
                            grid: { color: 'rgba(255,255,255,0.04)', drawBorder: false },
                            ticks: { color: '#8A8F98', font: { size: 11 } }
                        },
                        y: {
                            type: 'linear',
                            display: true,
                            position: 'left',
                            title: { display: true, text: 'WPM', color: '#5E6AD2', font: { size: 11 } },
                            grid: { color: 'rgba(255,255,255,0.04)', drawBorder: false },
                            ticks: { color: '#8A8F98', font: { size: 11 } }
                        },
                        y1: {
                            type: 'linear',
                            display: true,
                            position: 'right',
                            min: 0,
                            max: 100,
                            title: { display: true, text: 'Accuracy %', color: '#22c55e', font: { size: 11 } },
                            grid: { drawOnChartArea: false },
                            ticks: { color: '#8A8F98', font: { size: 11 } }
                        }
                    }
                }
            });
        }
    }
});
