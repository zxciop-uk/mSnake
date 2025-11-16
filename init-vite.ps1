# Set your project name
$projectName = "mSnake"

# Create the project folder
npm create vite@latest $projectName -- --template vanilla

# Change directory
Set-Location $projectName

# Install dependencies
npm install
npm install three
