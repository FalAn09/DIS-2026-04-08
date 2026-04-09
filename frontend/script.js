document.getElementById('helloBtn').addEventListener('click', async () => {
    const messageDiv = document.getElementById('message');
    messageDiv.textContent = 'Loading...';
    
    try {
        console.log('Fetching from: http://backend:5000/api/hello');
        const response = await fetch('http://backend:5000/api/hello');
        
        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }
        
        const data = await response.json();
        messageDiv.textContent = data.message || 'No message returned';
        console.log('Success:', data);
    } catch (error) {
        console.error('Error:', error);
        messageDiv.textContent = 'Error: ' + error.message;
        messageDiv.style.color = 'red';
    }
});