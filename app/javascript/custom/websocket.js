let websocket;

function connectWebSocket(onMessage) {
    websocket = new WebSocket(WEBSOCKET_URL);

    websocket.onopen = () => {
        console.log("WebSocket connected.");
        updateStatus('Connected to WebSocket!', '#28a745');
    };

    websocket.onerror = (error) => {
        console.error("WebSocket error:", error);
        updateStatus('WebSocket error!', '#dc3545');
    };

    websocket.onclose = () => {
        console.warn("WebSocket closed. Attempting to reconnect...");
        updateStatus('Reconnecting...', '#ff0000');
        setTimeout(() => connectWebSocket(onMessage), 3000);
    };

    if (onMessage) {
        websocket.onmessage = onMessage;
    }
}
