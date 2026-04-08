document.getElementById('helloBtn').addEventListener('click', async () => {
    try {
        const response = await fetch('http://backend:5000/api/hello');
        const data = await response.json();
        document.getElementById('message').textContent = data.message;
    } catch (error) {
        document.getElementById('message').textContent = 'Error: ' + error.message;
    }
});