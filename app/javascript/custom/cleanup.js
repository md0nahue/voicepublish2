function setupCleanup() {
    window.addEventListener('beforeunload', cleanup);
    disconnectBtn.addEventListener('click', disconnect);
}

function cleanup() {
    if (mediaRecorder && mediaRecorder.state !== 'inactive') mediaRecorder.stop();
    if (animationId) cancelAnimationFrame(animationId);
    if (audioContext) audioContext.close();
    if (websocket) websocket.close();
}

function disconnect() {
    console.log("Disconnect button clicked.");
    if (mediaRecorder && mediaRecorder.state !== "inactive") mediaRecorder.stop();

    setTimeout(() => {
        if (websocket && websocket.readyState === WebSocket.OPEN) {
            websocket.send("FINAL_CHUNK");
            websocket.close();
        }
    }, 300);

    if (animationId) cancelAnimationFrame(animationId);
    if (audioContext) audioContext.close();

    updateStatus("Disconnected.", "#dc3545");
}
