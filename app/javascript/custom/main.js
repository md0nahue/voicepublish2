window.addEventListener('load', async () => {
    try {
        connectWebSocket(); // sets global `websocket`

        audioStream = await navigator.mediaDevices.getUserMedia({ audio: true });
        updateStatus('Recording now!', '#28a745');

        setupAudioContext(audioStream);
        visualize();
        setupMediaRecorder(audioStream, websocket);
        setupCleanup();

    } catch (err) {
        console.error('Error accessing microphone:', err);
        updateStatus('Microphone access denied.', '#dc3545');
    }
});
