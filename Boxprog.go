package main
import(

"ethos/syscall"
ethosLog "ethos/log"
"ethos/efmt"
"ethos/ethos"
"math"
)
func main() {

me := syscall.GetUser()
path := "/user/" +me+ "/myDir/"
status := ethosLog.RedirectToLog("Boxprog")
if status != syscall.StatusOk {
efmt.Fprint(syscall.Stderr, "Error opening %v: %v\n", path,status)
syscall.Exit(syscall.StatusOk)
}

data1 := new(Box)
data2 := new(Box)
fd, status := ethos.OpenDirectoryPath(path)
data1.x1=5.0
data1.y1=10.0
data1.x2=15.0
data1.y2=20.0
data2.x1=math.Sqrt(data1.x1)
data2.y1=math.Sqrt(data1.y1)
data2.x2=math.Sqrt(data1.x2)
data2.y2=math.Sqrt(data1.y2)
data1.Write(fd)
data1.WriteVar(path+"foobar")
efmt.Fprint(syscall.Stderr, "\ncompleted successfully")
efmt.Printf("\n\n\n\n\n\n\nSquareroot of First coordinate x1(%f) : %f",data1.x1, data2.x1)
efmt.Printf("\nSquareroot of First coordinate y1(%f) : %f", data1.y1,data2.y1)
efmt.Printf("\nSquareroot of Second coordinate x2(%f) : %f",data1.x2,data2.x2)
efmt.Printf("\nSquareroot of Second coordinate y2:(%f) : %f",data1.y2,data2.y2)

}
