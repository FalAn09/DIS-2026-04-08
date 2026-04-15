document.getElementById('helloBtn').addEventListener('click', async () => {
    const messageDiv = document.getElementById('message');
    messageDiv.textContent = 'Loading...';
    
    try {
        console.log('Fetching from: /api/hello');
        const response = await fetch('/api/hello');
        
        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }
        
        const data = await response.json();
        messageDiv.textContent = data.message || 'No message returned';
        messageDiv.style.color = 'green';
        console.log('Success:', data);
    } catch (error) {
        console.error('Error:', error);
        messageDiv.textContent = 'Error: ' + error.message;
        messageDiv.style.color = 'red';
    }
});
// branch refactor/api_methods: refactor placeholder comment
