<%
' Check if the ASPUpload component is installed
If Not IsObject(Server.CreateObject("Persits.Upload")) Then
    Response.Write("ASPUpload component is not installed.")
    Response.End
End If

' Create an instance of the Upload object
Set Upload = Server.CreateObject("Persits.Upload")

' Set the directory where uploaded files will be saved
Upload.SavePath = Server.MapPath("uploads/")

' Attempt to save the uploaded file
On Error Resume Next
Upload.Save

If Err.Number <> 0 Then
    Response.Write("An error occurred: " & Err.Description)
Else
    ' Display uploaded file details
    For Each File in Upload.Files
        Response.Write("File uploaded successfully!<br>")
        Response.Write("File name: " & File.FileName & "<br>")
        Response.Write("File size: " & File.Size & " bytes<br>")
        Response.Write("Saved as: " & File.Path & "<br>")
    Next
End If

' Clean up
Set Upload = Nothing
%>
