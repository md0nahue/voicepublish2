// UI Elements
const statusEl = document.getElementById('status');
const canvas = document.getElementById('waveform');
const canvasCtx = canvas.getContext('2d');
const disconnectBtn = document.getElementById("disconnectBtn");

function updateStatus(text, color) {
    statusEl.textContent = text;
    statusEl.style.color = color;
}
