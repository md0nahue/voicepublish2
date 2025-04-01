let mediaRecorder;

function initializeMediaRecorder(stream) {
    let options = { mimeType: 'audio/webm;codecs=opus' };

    if (!MediaRecorder.isTypeSupported(options.mimeType)) {
        if (MediaRecorder.isTypeSupported('audio/ogg;codecs=opus')) {
            options.mimeType = 'audio/ogg;codecs=opus';
        } else if (MediaRecorder.isTypeSupported('audio/webm')) {
            options.mimeType = 'audio/webm';
        } else if (MediaRecorder.isTypeSupported('audio/ogg')) {
            options.mimeType = 'audio/ogg';
        } else {
            options = {};
        }
    }

    return new MediaRecorder(stream, options);
}

function setupMediaRecorder(stream, websocket) {
    try {
        mediaRecorder = initializeMediaRecorder(stream);
    } catch (e) {
        updateStatus('MediaRecorder not supported.', '#dc3545');
        return;
    }

    mediaRecorder.ondataavailable = (event) => {
        if (event.data && event.data.size > 0 && websocket.readyState === WebSocket.OPEN) {
            websocket.send(event.data);
        }
    };

    mediaRecorder.start(250);
}
