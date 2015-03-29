/*
copy from
http://www.autohotkey.com/community/viewtopic.php?t=87107
I'm trying to write my AHK script to send an e-mail. I would be sending the email from gmail.com:

example of what I'm trying to do:
If var=8
{
send e-mail from abc@gmail.com to xyz@yahoo.com, subject = check news, text body = the news is good
}

I know something like this must have been asked before, but spending 40 minutes in search just made me more confused.

Thanks all!
*/

SendMail(sender, senderPass, receiver, subject, message)
{
    fields := Object()
    fields.smtpserver := "smtp.gmail.com"
    fields.smtpserverport := 465
    fields.smtpusessl := True
    fields.sendusing := 2
    fields.smtpauthenticate := 1
    fields.sendusername := sender
    fields.sendpassword := senderPass
    fields.smtpconnectiontimeout := 60
    schema := "http://schemas.microsoft.com/cdo/configuration/"

    pmsg := ComObjCreate("CDO.Message")
    pmsg.To := receiver, pmsg.Subject := subject, pmsg.TextBody := message, pmsg.From := fields.sendusername

    pfld := pmsg.Configuration.Fields
    For field,value in fields
        pfld.Item(schema . field) := value
    pfld.Update()
    pmsg.Send()
}
