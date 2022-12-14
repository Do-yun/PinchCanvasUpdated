
# ChocolateIT


## Demo Video
Pinching gesture: (https://drive.google.com/file/d/1itLvbSSy6LYuQXeHi8Be7Wi9P5Dd_zgw/view?usp=sharing)<br />
Time synchronization: (https://drive.google.com/file/d/1h7GA1qtWhuL1PgvAYrvozBwMq_M4bstM/view?usp=sharing)

## Requirements

- Xcode 11.0+
- iOS 8.1+

## Execution of code
Download the code, open in Xcode **Examples** -> **PinchCanvas** -> **PinchCanvas.xcworkspace**

## Application usage
Once the application is open, it automatically connects all the devices found. There are two textfields on the top of the screen.<br/> The fist one is to enter the video identifier. 
* For example, if the url of the video is https://www.youtube.com/watch?v=DVNwiAPuPTY , the video identifier is DVNwiAPuPTY.<br/>Make sure that you enter 11 characters, otherwise the application will report an error.<br/>


The second textfield is for time synchronization, time unit is in second. After clicking 'enter', all the screens that join the screen sharing will jump to the designated moment that you have entered before.
* For example, if you want to jump to 1'30'', then enter 90.0 


