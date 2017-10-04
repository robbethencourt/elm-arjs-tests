import './main.css'
import { Main } from './Main.elm'

const app = Main.embed(document.getElementById('root'))

app.ports.sendImageToArjs.subscribe((imageUrl) => {
  // create aFrame elements
  const arjsContent = document.getElementById('arjs-content')
  const arScene = document.createElement('a-scene')
  const aImage = document.createElement('a-image')
  const aMarker = document.createElement('a-marker-camera')

  // set attributes on a-image
  aImage.setAttribute('src', imageUrl)
  aImage.setAttribute('width', '1.67')
  aImage.setAttribute('position', {x: 0, y: 0, z: 0})
  aImage.setAttribute('scale', '1 1 1')
  aImage.setAttribute('rotation', '90 -90 90')

  // set attributes on a-marker-camera
  aMarker.setAttribute('a-marker-camera', 'hiro')

  // append the elements to the scene and then to the arjs-content div in index.html
  arScene.appendChild(aImage)
  arScene.appendChild(aMarker)
  arjsContent.appendChild(arScene)
})
