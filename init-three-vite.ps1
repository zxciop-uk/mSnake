# Set your project name
$projectName = "three-vite-demo"

# Create the project folder
npm create vite@latest $projectName -- --template vanilla

# Change directory
Set-Location $projectName

# Install dependencies
npm install
npm install three

# Inject demo boilerplate into src/main.js
Set-Content -Path "./src/main.js" -Value @"
import * as THREE from 'three';

// Scene
const scene = new THREE.Scene();
scene.background = new THREE.Color(0x222222);

// Camera
const camera = new THREE.PerspectiveCamera(75, window.innerWidth/window.innerHeight, 0.1, 1000);
camera.position.z = 5;

// Renderer
const renderer = new THREE.WebGLRenderer({ antialias: true });
renderer.setSize(window.innerWidth, window.innerHeight);
document.body.appendChild(renderer.domElement);

// Cube
const geometry = new THREE.BoxGeometry();
const material = new THREE.MeshStandardMaterial({ color: 0x0077ff });
const cube = new THREE.Mesh(geometry, material);
scene.add(cube);

// Lights
const light = new THREE.DirectionalLight(0xffffff, 1);
light.position.set(5, 5, 5).normalize();
scene.add(light);

// Resize
window.addEventListener('resize', () => {
    camera.aspect = window.innerWidth / window.innerHeight;
    camera.updateProjectionMatrix();
    renderer.setSize(window.innerWidth, window.innerHeight);
});

// Animate
function animate() {
    requestAnimationFrame(animate);
    cube.rotation.y += 0.01;
    renderer.render(scene, camera);
}
animate();
"@

# Inject into index.html (canvas-free, let JS append it)
Set-Content -Path "./index.html" -Value @"
<!DOCTYPE html>
<html lang=""en"">
<head>
  <meta charset=""UTF-8"" />
  <meta name=""viewport"" content=""width=device-width, initial-scale=1.0"" />
  <title>Three.js Vite Demo</title>
  <style>
    html, body { margin: 0; padding: 0; height: 100%; overflow: hidden; }
    canvas { display: block; width: 100vw; height: 100vh; }
  </style>
</head>
<body>
  <script type=""module"" src=""/src/main.js""></script>
</body>
</html>
"@

# DONE!
Write-Host "✨ Project setup complete. Run it with: npm run dev"