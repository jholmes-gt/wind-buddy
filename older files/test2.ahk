#NoEnv
SetBatchLines, -1
#Include Chrome.ahk

page := Chrome.GetPage()
MsgBox, % IsObject(page)


/*
FileCreateDir, ChromeProfile
ChromeInst := new Chrome("ChromeProfile", "https://windchum.com/checkpoint-challenge/")
PageInst := ChromeInst.GetPage()


gctommy_tours_url := "https://www.golfclashtommy.com/tour"
PageInst.Call("Page.navigate", {"url": gctommy_tours_url})


MsgBox, % IsObject(PageInst)
*/