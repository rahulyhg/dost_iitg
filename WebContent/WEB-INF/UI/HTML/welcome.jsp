<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
    	<!-- NAME: 1:2:1 COLUMN - BANDED -->
        <meta name="viewport" content="width=device-width">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Your D.O.S.T - IITG : An Emotional Support System</title>

<style type="text/css">
		#mainUrl{
			background-color:#FFCC33;
			padding:10px;
			margin-left:150px;
			margin-right:125px;
			width:270px;
		}
		#mainUrl a{
			text-decoration:none;
		}
		p{
			margin:1em 0;
		}
		a{
			word-wrap:break-word;
		}
		table{
			border-collapse:collapse;
		}
		h1,h2,h3,h4,h5,h6{
			display:block;
			margin:0;
			padding:0;
		}
		img,a img{
			border:0;
			height:auto;
			outline:none;
			text-decoration:none;
		}
		body,#bodyTable,#bodyCell{
			height:100% !important;
			margin:0;
			padding:0;
			width:100% !important;
		}
		#outlook a{
			padding:0;
		}
		img{
			-ms-interpolation-mode:bicubic;
		}
		table{
			mso-table-lspace:0pt;
			mso-table-rspace:0pt;
		}
		.ReadMsgBody{
			width:100%;
		}
		.ExternalClass{
			width:100%;
		}
		p,a,li,td,blockquote{
			mso-line-height-rule:exactly;
		}
		a[href^=tel],a[href^=sms]{
			color:inherit;
			cursor:default;
			text-decoration:none;
		}
		p,a,li,td,body,table,blockquote{
			-ms-text-size-adjust:100%;
			-webkit-text-size-adjust:100%;
		}
		.ExternalClass,.ExternalClass p,.ExternalClass td,.ExternalClass div,.ExternalClass span,.ExternalClass font{
			line-height:100%;
		}
		#templatePreheader,#templateHeader,#templateUpperBody,#templateColumns,#templateLowerBody,#templateFooter{
			padding-right:10px;
			padding-left:10px;
		}
		.templateContainer{
			max-width:600px;
		}
		.columnsContainer{
			max-width:298px;
		}
		a.mcnButton{
			display:block;
		}
		.mcnImage{
			vertical-align:bottom;
		}
		.mcnTextContent img{
			height:auto !important;
		}
	/*
	@tab Page
	@section background style
	@tip Set the background color and top border for your email. You may want to choose colors that match your company's branding.
	*/
		#bodyCell{
			/*@editable*/border-top:0;
		}
	/*
	@tab Page
	@section heading 1
	@tip Set the styling for all first-level headings in your emails. These should be the largest of your headings.
	@style heading 1
	*/
		h1{
			/*@editable*/color:#606060 !important;
			/*@editable*/font-family:Arial,Helvetica,sans-serif;
			/*@editable*/font-size:40px;
			/*@editable*/font-style:normal;
			/*@editable*/font-weight:bold;
			/*@editable*/line-height:125%;
			/*@editable*/letter-spacing:-1px;
			/*@editable*/text-align:left;
		}
	/*
	@tab Page
	@section heading 2
	@tip Set the styling for all second-level headings in your emails.
	@style heading 2
	*/
		h2{
			/*@editable*/color:#404040 !important;
			;
                /*@editable*/ font-family:Arial,Helvetica,sans-serif;
			/*@editable*/font-size:26px;
			/*@editable*/font-style:normal;
			/*@editable*/font-weight:bold;
			/*@editable*/line-height:125%;
			/*@editable*/letter-spacing:-.75px;
			/*@editable*/text-align:left;
		}
	/*
	@tab Page
	@section heading 3
	@tip Set the styling for all third-level headings in your emails.
	@style heading 3
	*/
		h3{
			/*@editable*/color:#606060 !important;
			/*@editable*/font-family:Arial,Helvetica,sans-serif;
			/*@editable*/font-size:18px;
			/*@editable*/font-style:normal;
			/*@editable*/font-weight:bold;
			/*@editable*/line-height:125%;
			/*@editable*/letter-spacing:-.5px;
			/*@editable*/text-align:left;
		}
	/*
	@tab Page
	@section heading 4
	@tip Set the styling for all fourth-level headings in your emails. These should be the smallest of your headings.
	@style heading 4
	*/
		h4{
			/*@editable*/color:#808080 !important;
			/*@editable*/font-family:Arial,Helvetica,sans-serif;
			/*@editable*/font-size:16px;
			/*@editable*/font-style:normal;
			/*@editable*/font-weight:bold;
			/*@editable*/line-height:125%;
			/*@editable*/letter-spacing:normal;
			/*@editable*/text-align:left;
		}
	/*
	@tab Preheader
	@section preheader style
	@tip Set the background color and borders for your email's preheader area.
	*/
		#templatePreheader{
			/*@editable*/background-color:#FFFFFF;
			/*@editable*/border-top:0;
			/*@editable*/border-bottom:0;
		}
	/*
	@tab Preheader
	@section preheader text
	@tip Set the styling for your email's preheader text. Choose a size and color that is easy to read.
	*/
		.preheaderContainer .mcnTextContent,.preheaderContainer .mcnTextContent p{
			/*@editable*/color:#606060;
			/*@editable*/font-family:Helvetica;
			/*@editable*/font-size:11px;
			/*@editable*/line-height:125%;
			/*@editable*/text-align:left;
		}
	/*
	@tab Preheader
	@section preheader link
	@tip Set the styling for your email's header links. Choose a color that helps them stand out from your text.
	*/
		.preheaderContainer .mcnTextContent a{
			/*@editable*/color:#606060;
			/*@editable*/font-weight:normal;
			/*@editable*/text-decoration:underline;
		}
	/*
	@tab Header
	@section header style
	@tip Set the background color and borders for your email's header area.
	*/
		#templateHeader{
			/*@editable*/background-color:#FFFFFF;
			/*@editable*/border-top:0;
			/*@editable*/border-bottom:0;
		}
	/*
	@tab Header
	@section header text
	@tip Set the styling for your email's header text. Choose a size and color that is easy to read.
	*/
		.headerContainer .mcnTextContent,.headerContainer .mcnTextContent p{
			
			/*@editable*/font-family:Arial,Helvetica,sans-serif;
			/*@editable*/font-size:12px;
			/*@editable*/line-height:150%;
			/*@editable*/text-align:left;
		}
	/*
	@tab Header
	@section header link
	@tip Set the styling for your email's header links. Choose a color that helps them stand out from your text.
	*/
		.headerContainer .mcnTextContent a{
			/*@editable*/color:black;
			/*@editable*/font-weight:bold;
			/*@editable*/text-decoration:underline;
		}
	/*
	@tab Upper Body
	@section upper body style
	@tip Set the background color and borders for your email's body area.
	*/
		#templateUpperBody{
			/*@editable*/background-color:#FFFFFF;
			/*@editable*/border-top:0;
			/*@editable*/border-bottom:0;
		}
	/*
	@tab Upper Body
	@section upper body text
	@tip Set the styling for your email's body text. Choose a size and color that is easy to read.
	*/
		.upperBodyContainer .mcnTextContent,.upperBodyContainer .mcnTextContent p{
			/*@editable*/color:#606060;
			/*@editable*/font-family:Arial,Helvetica,sans-serif;
			/*@editable*/font-size:12px;
			/*@editable*/line-height:150%;
			/*@editable*/text-align:left;
		}
	/*
	@tab Upper Body
	@section upper body link
	@tip Set the styling for your email's body links. Choose a color that helps them stand out from your text.
	*/
		.upperBodyContainer .mcnTextContent a{
			/*@editable*/color:#6DC6DD;
			/*@editable*/font-weight:normal;
			/*@editable*/text-decoration:underline;
		}
	/*
	@tab Columns
	@section column style
	@tip Set the background color and borders for your email's columns.
	*/
		#templateColumns{
			/*@editable*/background-color:#FFFFFF;
			/*@editable*/border-top:0;
			/*@editable*/border-bottom:0;
		}
	/*
	@tab Columns
	@section left column style
	@tip Set the styling for your email's left column text. Choose a size and color that is easy to read.
	*/
		.leftColumnContainer .mcnTextContent,.leftColumnContainer .mcnTextContent p{
			/*@editable*/color:#606060;
			/*@editable*/font-family:Arial,Helvetica,sans-serif;
			/*@editable*/font-size:12px;
			/*@editable*/line-height:150%;
			/*@editable*/text-align:left;
		}
	/*
	@tab Columns
	@section left column link
	@tip Set the styling for your email's left column links. Choose a color that helps them stand out from your text.
	*/
		.leftColumnContainer .mcnTextContent a,.leftColumnContainer .mcnTextContent p a{
			/*@editable*/color:#6DC6DD;
			/*@editable*/font-weight:normal;
			/*@editable*/text-decoration:underline;
		}
	/*
	@tab Columns
	@section right column style
	@tip Set the styling for your email's right column text. Choose a size and color that is easy to read.
	*/
		.rightColumnContainer .mcnTextContent,.rightColumnContainer .mcnTextContent p{
			/*@editable*/color:#606060;
			/*@editable*/font-family:Helvetica;
			/*@editable*/font-size:12px;
			/*@editable*/line-height:150%;
			/*@editable*/text-align:left;
		}
	/*
	@tab Columns
	@section right column link
	@tip Set the styling for your email's right column links. Choose a color that helps them stand out from your text.
	*/
		.rightColumnContainer .mcnTextContent a,.rightColumnContainer .mcnTextContent p a{
			/*@editable*/color:#6DC6DD;
			/*@editable*/font-weight:normal;
			/*@editable*/text-decoration:underline;
		}
	/*
	@tab Lower Body
	@section lower body style
	@tip Set the background color and borders for your email's body area.
	*/
		#templateLowerBody{
			/*@editable*/background-color:#FFFFFF;
			/*@editable*/border-top:0;
			/*@editable*/border-bottom:0;
		}
	/*
	@tab Lower Body
	@section lower body text
	@tip Set the styling for your email's body text. Choose a size and color that is easy to read.
	*/
		.lowerBodyContainer .mcnTextContent,.lowerBodyContainer .mcnTextContent p{
			/*@editable*/color:#606060;
			/*@editable*/font-family:Arial,Helvetica,sans-serif;
			/*@editable*/font-size:12px;
			/*@editable*/line-height:150%;
			/*@editable*/text-align:left;
		}
	/*
	@tab Lower Body
	@section lower body link
	@tip Set the styling for your email's body links. Choose a color that helps them stand out from your text.
	*/
		.lowerBodyContainer .mcnTextContent a{
			/*@editable*/color:#6DC6DD;
			/*@editable*/font-weight:normal;
			/*@editable*/text-decoration:underline;
		}
	/*
	@tab Footer
	@section footer style
	@tip Set the background color and borders for your email's footer area.
	*/
		body,#bodyTable,#templateFooter{
			/*@editable*/background-color:#F2F2F2;
			/*@editable*/border-top:0;
			/*@editable*/border-bottom:0;
		}
	/*
	@tab Footer
	@section footer text
	@tip Set the styling for your email's footer text. Choose a size and color that is easy to read.
	*/
		.footerContainer .mcnTextContent,.footerContainer .mcnTextContent p{
			/*@editable*/color:#606060;
			/*@editable*/font-family:Arial,Helvetica,sans-serif;
			/*@editable*/font-size:11px;
			/*@editable*/line-height:125%;
			/*@editable*/text-align:center;
		}
	/*
	@tab Footer
	@section footer link
	@tip Set the styling for your email's footer links. Choose a color that helps them stand out from your text.
	*/
		.footerContainer .mcnTextContent a{
			/*@editable*/color:#606060;
			/*@editable*/font-weight:normal;
			/*@editable*/text-decoration:underline;
		}
	@media screen and (min-width:768px){
		.templateContainer{
			width:600px !important;
		}

}	@media screen and (min-width:768px){
		.columnsContainer{
			width:298px;
		}

}	@media only screen and (max-width:480px){
		body{
			width:100% !important;
			min-width:100% !important;
		}

}	@media only screen and (max-width:480px){
		td#bodyCell{
			padding-top:10px !important;
		}

}	@media only screen and (max-width:480px){
		.columnsContainer{
			max-width:100% !important;
			width:100% !important;
		}

}	@media only screen and (max-width:480px){
		img.mcnImage,table.mcnShareContent,table.mcnCaptionTopContent,table.mcnCaptionBottomContent,table.mcnTextContentContainer,table.mcnBoxedTextContentContainer,table.mcnImageGroupContentContainer,table.mcnCaptionLeftTextContentContainer,table.mcnCaptionRightTextContentContainer,table.mcnCaptionLeftImageContentContainer,table.mcnCaptionRightImageContentContainer,table.mcnImageCardLeftTextContentContainer,table.mcnImageCardRightTextContentContainer{
			width:100% !important;
		}

}	@media only screen and (max-width:480px){
		td.mcnImageGroupContent{
			padding:9px !important;
		}

}	@media only screen and (max-width:480px){
		table.mcnCaptionLeftContentOuter td.mcnTextContent,table.mcnCaptionRightContentOuter td.mcnTextContent{
			padding-top:9px !important;
		}

}	@media only screen and (max-width:480px){
		td.mcnImageCardTopImageContent,td.mcnCaptionBlockInner table.mcnCaptionTopContent:last-child td.mcnTextContent{
			padding-top:18px !important;
		}

}	@media only screen and (max-width:480px){
		td.mcnImageCardBottomImageContent{
			padding-bottom:9px !important;
		}

}	@media only screen and (max-width:480px){
		td.mcnImageGroupBlockInner{
			padding-top:0 !important;
			padding-bottom:0 !important;
		}

}	@media only screen and (max-width:480px){
		tbody.mcnImageGroupBlockOuter{
			padding-top:9px !important;
			padding-bottom:9px !important;
		}

}	@media only screen and (max-width:480px){
		td.mcnTextContent,td.mcnBoxedTextContentColumn{
			padding-right:18px !important;
			padding-left:18px !important;
		}

}	@media only screen and (max-width:480px){
		td.mcnImageCardLeftImageContent,td.mcnImageCardRightImageContent{
			padding-right:18px !important;
			padding-bottom:0 !important;
			padding-left:18px !important;
		}

}	@media only screen and (max-width:480px){
		td.columnsContainer{
			display:block !important;
			max-width:600px !important;
			width:100% !important;
		}

}	@media only screen and (max-width:480px){
		table.mcpreview-image-uploader{
			display:none !important;
			width:100% !important;
		}

}	@media only screen and (max-width:480px){
		td.footerContainer a.utilityLink{
			display:block !important;
		}

}	@media only screen and (max-width:480px){
	/*
	@tab Mobile Styles
	@section heading 1
	@tip Make the first-level headings larger in size for better readability on small screens.
	*/
		h1{
			/*@editable*/font-size:24px !important;
			/*@editable*/line-height:125% !important;
		}

}	@media only screen and (max-width:480px){
	/*
	@tab Mobile Styles
	@section heading 2
	@tip Make the second-level headings larger in size for better readability on small screens.
	*/
		h2{
			/*@editable*/font-size:20px !important;
			/*@editable*/line-height:125% !important;
		}

}	@media only screen and (max-width:480px){
	/*
	@tab Mobile Styles
	@section heading 3
	@tip Make the third-level headings larger in size for better readability on small screens.
	*/
		h3{
			/*@editable*/font-size:18px !important;
			/*@editable*/line-height:125% !important;
		}

}	@media only screen and (max-width:480px){
	/*
	@tab Mobile Styles
	@section heading 4
	@tip Make the fourth-level headings larger in size for better readability on small screens.
	*/
		h4{
			/*@editable*/font-size:16px !important;
			/*@editable*/line-height:125% !important;
		}

}	@media only screen and (max-width:480px){
	/*
	@tab Mobile Styles
	@section Boxed Text
	@tip Make the boxed text larger in size for better readability on small screens. We recommend a font size of at least 16px.
	*/
		table.mcnBoxedTextContentContainer td.mcnTextContent,td.mcnBoxedTextContentContainer td.mcnTextContent p{
			/*@editable*/font-size:18px !important;
			/*@editable*/line-height:125% !important;
		}

}	@media only screen and (max-width:480px){
	/*
	@tab Mobile Styles
	@section Preheader Visibility
	@tip Set the visibility of the email's preheader on small screens. You can hide it to save space.
	*/
		td#templatePreheader{
			/*@editable*/display:block !important;
		}

}	@media only screen and (max-width:480px){
	/*
	@tab Mobile Styles
	@section Preheader Text
	@tip Make the preheader text larger in size for better readability on small screens.
	*/
		td.preheaderContainer td.mcnTextContent,td.preheaderContainer td.mcnTextContent p{
			/*@editable*/font-size:12px !important;
			/*@editable*/line-height:115% !important;
		}

}	@media only screen and (max-width:480px){
	/*
	@tab Mobile Styles
	@section Header Text
	@tip Make the header text larger in size for better readability on small screens.
	*/
		td.headerContainer td.mcnTextContent,td.headerContainer td.mcnTextContent p{
			/*@editable*/font-size:18px !important;
			/*@editable*/line-height:125% !important;
		}

}	@media only screen and (max-width:480px){
	/*
	@tab Mobile Styles
	@section Upper Body Text
	@tip Make the body text larger in size for better readability on small screens. We recommend a font size of at least 16px.
	*/
		td.upperBodyContainer td.mcnTextContent,td.upperBodyContainer td.mcnTextContent p{
			/*@editable*/font-size:18px !important;
			/*@editable*/line-height:125% !important;
		}

}	@media only screen and (max-width:480px){
	/*
	@tab Mobile Styles
	@section Left Column Text
	@tip Make the left column text larger in size for better readability on small screens. We recommend a font size of at least 16px.
	*/
		td.leftColumnContainer td.mcnTextContent,td.leftColumnContainer td.mcnTextContent p{
			/*@tab Mobile Styles
@section Left Column Text
@tip Make the left column text larger in size for better readability on small screens. We recommend a font size of at least 16px.*/font-size:16px !important;
			line-height:125% !important;
		}

}	@media only screen and (max-width:480px){
	/*
	@tab Mobile Styles
	@section Right Column Text
	@tip Make the right column text larger in size for better readability on small screens. We recommend a font size of at least 16px.
	*/
		td.rightColumnContainer td.mcnTextContent,td.rightColumnContainer td.mcnTextContent p{
			/*@tab Mobile Styles
@section Right Column Text
@tip Make the right column text larger in size for better readability on small screens. We recommend a font size of at least 16px.*/font-size:16px !important;
			line-height:125% !important;
		}

}	@media only screen and (max-width:480px){
	/*
	@tab Mobile Styles
	@section Lower Body Text
	@tip Make the body text larger in size for better readability on small screens. We recommend a font size of at least 16px.
	*/
		td.lowerBodyContainer td.mcnTextContent,td.lowerBodyContainer td.mcnTextContent p{
			/*@editable*/font-size:18px !important;
			/*@editable*/line-height:125% !important;
		}

}	@media only screen and (max-width:480px){
	/*
	@tab Mobile Styles
	@section footer text
	@tip Make the body content text larger in size for better readability on small screens.
	*/
		td.footerContainer td.mcnTextContent,td.footerContainer td.mcnTextContent p{
			/*@editable*/font-size:12px !important;
			/*@editable*/line-height:115% !important;
		}

}</style></head>
<body>
	<div style="width:600px; margin: 0 auto; line-height:16px; font-family: Arial, helvetica, sans-serif; color:#000000">
		<center>
			<table border="0" cellpadding="0" cellspacing="0" height="100%" width="100%" id="bodyTable">
				<tr>
					<td align="center" valign="top" id="bodyCell">
						<table border="0" cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td align="center" valign="top" id="templatePreheader">
                                    <!-- BEGIN PREHEADER // -->
									<!--[if gte mso 9]>
									<table align="center" border="0" cellspacing="0" cellpadding="0" style="width:600px;" width="600">
									<tr>
									<td align="center" valign="top">
									<![endif]-->
                                    <table border="0" cellpadding="0" cellspacing="0" width="100%" class="templateContainer">
                                        <tr>
                                        	<td valign="top" class="preheaderContainer"><table border="0" cellpadding="0" cellspacing="0" width="100%" class="mcnTextBlock">
    <tbody class="mcnTextBlockOuter">
        <tr>
            <td valign="top" class="mcnTextBlockInner">
                
        
                
            </td>
        </tr>
    </tbody>
</table></td>
                                        </tr>
                                    </table>
									<!--[if gte mso 9]>
									</td>
									</tr>
									</table>
									<![endif]-->
                                    <!-- // END PREHEADER -->
                                </td>
                            </tr>
                            <tr>
                                <td align="center" valign="top" id="templateHeader">
                                    <!-- BEGIN HEADER // -->
									<!--[if gte mso 9]>
									<table align="center" border="0" cellspacing="0" cellpadding="0" style="width:600px;" width="600">
									<tr>
									<td align="center" valign="top">
									<![endif]-->
                                    <table border="0" cellpadding="0" cellspacing="0" width="100%" class="templateContainer">
                                        <tr>
                                            <td valign="top" class="headerContainer"><table border="0" cellpadding="0" cellspacing="0" width="100%" class="mcnImageBlock">
    <tbody class="mcnImageBlockOuter">
            <tr>
                <td valign="top" style="padding:9px" class="mcnImageBlockInner">
                    <table align="left" width="100%" border="0" cellpadding="0" cellspacing="0" class="mcnImageContentContainer">
                        <tbody><tr>
                            <td class="mcnImageContent" valign="top" style="padding-right: 9px; padding-left: 9px; padding-top: 0; padding-bottom: 0;">
                                
                                    
                                        <img align="left" alt="" src="https://gallery.mailchimp.com/56655a51519264aaf586b2aa4/images/256ecf00-4960-4a2e-aa4b-bf4a033074a5.jpg" width="564" style="max-width:948px; padding-bottom: 0; display: inline !important; vertical-align: bottom;" class="mcnImage">
                                    
                                
                            </td>
                        </tr>
                    </tbody></table>
                </td>
            </tr>
    </tbody>
</table><table border="0" cellpadding="0" cellspacing="0" width="100%" class="mcnTextBlock">
    <tbody class="mcnTextBlockOuter">
        <tr>
            <td valign="top" class="mcnTextBlockInner">
                
                <table align="left" border="0" cellpadding="0" cellspacing="0" width="600" class="mcnTextContentContainer">
                    <tbody><tr>
                        
                        <td valign="top" class="mcnTextContent" style="padding-top:0px; padding-right: 18px; padding-bottom: 9px; padding-left: 18px;">
                        
                            <h1 style="font-size: 14px;margin-bottom:10px;margin-top:10px">Hi Friends,</h1>

<p style="margin-top: 0pt; margin-bottom: 0pt; margin-left: 0in;">Sometimes life becomes difficult&nbsp;- "competitive environment, family expectations, loneliness, confusions, unstable relationships" - and not always are we able to share our worries with someone. Isn't it?&nbsp;</p><br>

<p style="line-height:16px;margin-top:10px">We have been there ourselves and out of our own need we&nbsp; created an online emotional support system -&nbsp;<br>

<div id="mainUrl"><a href="http://iitg.yourdost.com" target="_blank"><span style="font-size:24px">www.iitg.yourdost.com</span></a></div><br>
<p>for people like us to anonymously vent out our feelings.&nbsp; You can chat with&nbsp;psychologists and non-judgmental&nbsp;individuals, &nbsp;explore self help, share experiences&nbsp;and help peers going though tough times.&nbsp;</span>
&nbsp;</p>

<div>Your D.O.S.T in collaboration with IIT Guwahati wishes to create a more productive and happier environment.</div>

                        </td>
                    </tr>
                </tbody></table>
                
            </td>
        </tr>
    </tbody>
</table></td>
                                        </tr>
                                    </table>
									<!--[if gte mso 9]>
									</td>
									</tr>
									</table>
									<![endif]-->
                                    <!-- // END HEADER -->
                                </td>
                            </tr>
                            <tr>
                                <td align="center" valign="top" id="templateUpperBody">
                                    <!-- BEGIN UPPER BODY // -->
									<!--[if gte mso 9]>
									<table align="center" border="0" cellspacing="0" cellpadding="0" style="width:600px;" width="600">
									<tr>
									<td align="center" valign="top">
									<![endif]-->
                                    <table border="0" cellpadding="0" cellspacing="0" width="100%" class="templateContainer">
                                        <tr>
                                            <td valign="top" class="upperBodyContainer"></td>
                                        </tr>
                                    </table>
									<!--[if gte mso 9]>
									</td>
									</tr>
									</table>
									<![endif]-->
                                    <!-- // END UPPER BODY -->
                                </td>
                            </tr>
                            <tr>
                                <td align="center" valign="top" id="templateColumns">
                                	<!-- BEGIN COLUMNS // -->
                                    <table border="0" cellpadding="0" cellspacing="0" width="100%" class="templateContainer">
                                        <tr>
                                            <td align="center" valign="top">
                                                <!-- BEGIN INDIVIDUAL COLUMNS // -->
                                                <!--[if gte mso 9]>
                                                <table align="center" border="0" cellspacing="0" cellpadding="0" style="width:600px;" width="600">
                                                <tr>
                                                <td align="center" valign="top" style="width:298px;" width="298">
                                                <![endif]-->
                                                <table align="left" border="0" cellpadding="0" cellspacing="0" width="50%" class="columnsContainer">
                                                    <tr>
                                                        <td valign="top" class="leftColumnContainer"><table border="0" cellpadding="0" cellspacing="0" width="100%" class="mcnTextBlock">
    <tbody class="mcnTextBlockOuter">
        <tr>
            <td valign="top" class="mcnTextBlockInner">
                
                <table align="left" border="0" cellpadding="0" cellspacing="0" width="298" class="mcnTextContentContainer">
                    <tbody><tr>
                        
                        <td valign="top" class="mcnTextContent" style="padding-top:10px; padding-right: 18px; padding-bottom: 5px; padding-left: 18px;">
                        
                            <strong>From our Testimonials section :</strong>
                        </td>
                    </tr>
                </tbody></table>
                
            </td>
        </tr>
    </tbody>
</table><table border="0" cellpadding="0" cellspacing="0" width="100%" class="mcnBoxedTextBlock">
    <tbody class="mcnBoxedTextBlockOuter">
        <tr>
            <td valign="top" class="mcnBoxedTextBlockInner">
                
                <table align="left" border="0" cellpadding="0" cellspacing="0" width="298" class="mcnBoxedTextContentContainer">
                    <tbody><tr>
                        
                        <td style="padding-top:9px; padding-left:18px; padding-bottom:9px; padding-right:18px;">
                        
                            <table border="0" cellpadding="11" cellspacing="0" class="mcnTextContentContainer" width="100%" style="border: 1px solid #999999;background-color: #EBEBEB;">
                                <tbody><tr>
                                    <td valign="top" class="mcnTextContent">
                                        <p style="margin-top:0in;margin-right:0in;margin-bottom:7.5pt;margin-left:0in"><span>" Sir, definitely your words are encouraging and thanks for your support. now-a-days I am trying to get over my fear and stay cool in interviews.&nbsp;"&nbsp;</span><br>
<span> - <strong>Btech grad stressed with job hunt</strong><br>
<br>
" i am not going to give up. let life throw anything on me. "<br>
-&nbsp;<strong><span style="font-family:arial,sans-serif">dejected, lost due to exam failure</span></strong></span></p>

                                    </td>
                                </tr>
                            </tbody></table>
                        </td>
                    </tr>
                </tbody></table>
                
            </td>
        </tr>
    </tbody>
</table></td>
                                                    </tr>
                                                </table>
                                                <!--[if gte mso 9]>
                                                </td>
                                                <td align="center" valign="top" style="width:298px;" width="298">
                                                <![endif]-->
                                                <table align="left" border="0" cellpadding="0" cellspacing="0" width="50%" class="columnsContainer">
                                                    <tr>
                                                        <td valign="top" class="rightColumnContainer"><table border="0" cellpadding="0" cellspacing="0" width="100%" class="mcnCaptionBlock">
    <tbody class="mcnCaptionBlockOuter">
        <tr>
            <td class="mcnCaptionBlockInner" valign="top" style="padding:9px;">
                



<table align="left" border="0" cellpadding="0" cellspacing="0" class="mcnCaptionTopContent" width="false">
    <tbody><tr>
        <td class="mcnTextContent" valign="top" style="padding:0px 9px 8px 9px;" width="262">
            <strong style="line-height:20.7999992370605px">From our Blogs section :</strong>
        </td>
    </tr>
    <tr>
        <td class="mcnCaptionTopImageContent" align="left" valign="top" style="padding:7px 9px 0 9px;">
        
            
            <a href="http://yourdostiitg.blogspot.in/2015/03/this-is-my-second-blog-with-your-d.html" title="" class="" target="_blank">
            

            <img alt="" src="https://gallery.mailchimp.com/56655a51519264aaf586b2aa4/images/fb824b1d-0a62-401c-867a-d7eec1e8f4c2.jpg" width="262" style="max-width:800px;" class="mcnImage">

            </a>
        
        </td>
        
            
        
        </tr></tbody></table></td>
    </tr>
</tbody></table>



            </td>
        </tr>
    
</table></td>
                                                    </tr>
                                                </table>
                                                <!--[if gte mso 9]>
                                                </td>
                                                </tr>
                                                </table>
                                                <![endif]-->
                                                <!-- // END INDIVIDUAL COLUMNS -->
                                            </td>
                                        </tr>
                                    </table>
                                    <!-- // END COLUMNS -->
                                </td>
                            </tr>
                            <tr>
                                <td align="center" valign="top" id="templateLowerBody">
                                    <!-- BEGIN LOWER BODY // -->
									<!--[if gte mso 9]>
									<table align="center" border="0" cellspacing="0" cellpadding="0" style="width:600px;" width="600">
									<tr>
									<td align="center" valign="top">
									<![endif]-->
                                    <table border="0" cellpadding="0" cellspacing="0" width="100%" class="templateContainer">
                                        <tr>
                                            <td valign="top" class="lowerBodyContainer"><table border="0" cellpadding="0" cellspacing="0" width="100%" class="mcnFollowBlock">
    <tbody class="mcnFollowBlockOuter">
        <tr>
            <td align="center" valign="top" style="padding:9px" class="mcnFollowBlockInner">
                <table border="0" cellpadding="0" cellspacing="0" width="100%" class="mcnFollowContentContainer">
    <tbody><tr>
        <td align="center" style="padding-left:9px;padding-right:9px;">
            <table border="0" cellpadding="0" cellspacing="0" width="100%" class="mcnFollowContent" style="border: 1px solid #EEEEEE;background-color: #FAFAFA;">
                <tbody><tr>
                    <td align="center" valign="top" style="padding-top:9px; padding-right:9px; padding-left:9px;">
						<table border="0" cellpadding="0" cellspacing="0">
							<tbody><tr>
								<td valign="top">
			                        
			                            
			                            
			                                <table align="left" border="0" cellpadding="0" cellspacing="0">
			                                    <tbody><tr>
			                                        <td valign="top" style="padding-right:10px; padding-bottom:9px;" class="mcnFollowContentItemContainer">
			                                            <table border="0" cellpadding="0" cellspacing="0" width="100%" class="mcnFollowContentItem">
			                                                <tbody><tr>
			                                                    <td align="left" valign="middle" style="padding-top:5px; padding-right:10px; padding-bottom:5px; padding-left:9px;">
			                                                        <table align="left" border="0" cellpadding="0" cellspacing="0" width="">
			                                                            <tbody><tr>
			                                                                
			                                                                    <td align="center" valign="middle" width="24" class="mcnFollowIconContent">
			                                                                        <a href="https://www.facebook.com/yourtruedost" target="_blank"><img src="http://cdn-images.mailchimp.com/icons/social-block-v2/gray-facebook-48.png" style="display:block;" height="24" width="24" class=""></a>
			                                                                    </td>
			                                                                
			                                                                
			                                                                    <td align="left" valign="middle" class="mcnFollowTextContent" style="padding-left:5px;">
			                                                                        <a href="https://www.facebook.com/yourtruedost" target="" style="font-family: Arial;font-size: 11px;text-decoration: none;color: #606060;font-weight: normal;line-height: 100%;text-align: center;">Facebook</a>
			                                                                    </td>
			                                                                
			                                                            </tr>
			                                                        </tbody></table>
			                                                    </td>
			                                                </tr>
			                                            </tbody></table>
			                                        </td>
			                                    </tr>
			                                </tbody></table>
			                            
								<!--[if gte mso 6]>
								</td>
						    	<td align="left" valign="top">
								<![endif]-->
			                        
			                            
			                            
			                                <table align="left" border="0" cellpadding="0" cellspacing="0">
			                                    <tbody><tr>
			                                        <td valign="top" style="padding-right:10px; padding-bottom:9px;" class="mcnFollowContentItemContainer">
			                                            <table border="0" cellpadding="0" cellspacing="0" width="100%" class="mcnFollowContentItem">
			                                                <tbody><tr>
			                                                    <td align="left" valign="middle" style="padding-top:5px; padding-right:10px; padding-bottom:5px; padding-left:9px;">
			                                                        <table align="left" border="0" cellpadding="0" cellspacing="0" width="">
			                                                            <tbody><tr>
			                                                                
			                                                                    <td align="center" valign="middle" width="24" class="mcnFollowIconContent">
			                                                                        <a href="https://twitter.com/yourtruedost" target="_blank"><img src="http://cdn-images.mailchimp.com/icons/social-block-v2/gray-twitter-48.png" style="display:block;" height="24" width="24" class=""></a>
			                                                                    </td>
			                                                                
			                                                                
			                                                                    <td align="left" valign="middle" class="mcnFollowTextContent" style="padding-left:5px;">
			                                                                        <a href="https://twitter.com/yourtruedost" target="" style="font-family: Arial;font-size: 11px;text-decoration: none;color: #606060;font-weight: normal;line-height: 100%;text-align: center;">Twitter</a>
			                                                                    </td>
			                                                                
			                                                            </tr>
			                                                        </tbody></table>
			                                                    </td>
			                                                </tr>
			                                            </tbody></table>
			                                        </td>
			                                    </tr>
			                                </tbody></table>
			                            
								<!--[if gte mso 6]>
								</td>
						    	<td align="left" valign="top">
								<![endif]-->
			                        
			                            
			                            
			                                <table align="left" border="0" cellpadding="0" cellspacing="0">
			                                    <tbody><tr>
			                                        <td valign="top" style="padding-right:10px; padding-bottom:9px;" class="mcnFollowContentItemContainer">
			                                            <table border="0" cellpadding="0" cellspacing="0" width="100%" class="mcnFollowContentItem">
			                                                <tbody><tr>
			                                                    <td align="left" valign="middle" style="padding-top:5px; padding-right:10px; padding-bottom:5px; padding-left:9px;">
			                                                        <table align="left" border="0" cellpadding="0" cellspacing="0" width="">
			                                                            <tbody><tr>
			                                                                
			                                                                    <td align="center" valign="middle" width="24" class="mcnFollowIconContent">
			                                                                        <a href="http://iitg.yourdost.com/" target="_blank"><img src="http://cdn-images.mailchimp.com/icons/social-block-v2/gray-link-48.png" style="display:block;" height="24" width="24" class=""></a>
			                                                                    </td>
			                                                                
			                                                                
			                                                                    <td align="left" valign="middle" class="mcnFollowTextContent" style="padding-left:5px;">
			                                                                        <a href="http://iitg.yourdost.com/" target="" style="font-family: Arial;font-size: 11px;text-decoration: none;color: #606060;font-weight: normal;line-height: 100%;text-align: center;">Website</a>
			                                                                    </td>
			                                                                
			                                                            </tr>
			                                                        </tbody></table>
			                                                    </td>
			                                                </tr>
			                                            </tbody></table>
			                                        </td>
			                                    </tr>
			                                </tbody></table>
			                            
								<!--[if gte mso 6]>
								</td>
						    	<td align="left" valign="top">
								<![endif]-->
			                        
			                            
			                            
			                                <table align="left" border="0" cellpadding="0" cellspacing="0">
			                                    <tbody><tr>
			                                        <td valign="top" style="padding-right:0; padding-bottom:9px;" class="mcnFollowContentItemContainer">
			                                            <table border="0" cellpadding="0" cellspacing="0" width="100%" class="mcnFollowContentItem">
			                                                <tbody><tr>
			                                                    <td align="left" valign="middle" style="padding-top:5px; padding-right:10px; padding-bottom:5px; padding-left:9px;">
			                                                        <table align="left" border="0" cellpadding="0" cellspacing="0" width="">
			                                                            <tbody><tr>
			                                                                
			                                                                    <td align="center" valign="middle" width="24" class="mcnFollowIconContent">
			                                                                        <a href="mailto:yourdostiitg@gmail.com" target="_blank"><img src="http://cdn-images.mailchimp.com/icons/social-block-v2/gray-forwardtofriend-48.png" style="display:block;" height="24" width="24" class=""></a>
			                                                                    </td>
			                                                                
			                                                                
			                                                                    <td align="left" valign="middle" class="mcnFollowTextContent" style="padding-left:5px;">
			                                                                        <a href="mailto:yourdostiitg@gmail.com" target="" style="font-family: Arial;font-size: 11px;text-decoration: none;color: #606060;font-weight: normal;line-height: 100%;text-align: center;">Email</a>
			                                                                    </td>
			                                                                
			                                                            </tr>
			                                                        </tbody></table>
			                                                    </td>
			                                                </tr>
			                                            </tbody></table>
			                                        </td>
			                                    </tr>
			                                </tbody></table>
			                            
								<!--[if gte mso 6]>
								</td>
						    	<td align="left" valign="top">
								<![endif]-->
			                        
								</td>
							</tr>
						</tbody></table>
                    </td>
                </tr>
            </tbody></table>
        </td>
    </tr>
</tbody></table>

            </td>
        </tr>
    </tbody>
</table></td>
                                        </tr>
                                    </table>
									<!--[if gte mso 9]>
									</td>
									</tr>
									</table>
									<![endif]-->
                                    <!-- // END LOWER BODY -->
                                </td>
                            </tr>
                            <tr>
                                <td align="center" valign="top" id="templateFooter">
                                    <!-- BEGIN FOOTER // -->
									<!--[if gte mso 9]>
									<table align="center" border="0" cellspacing="0" cellpadding="0" style="width:600px;" width="600">
									<tr>
									<td align="center" valign="top">
									<![endif]-->
                                    <table border="0" cellpadding="0" cellspacing="0" width="100%" class="templateContainer">
                                        <tr>
                                            <td valign="top" class="footerContainer"><table border="0" cellpadding="0" cellspacing="0" width="100%" class="mcnTextBlock">
    <tbody class="mcnTextBlockOuter">
        <tr>
            <td valign="top" class="mcnTextBlockInner">
                
                <table align="left" border="0" cellpadding="0" cellspacing="0" width="600" class="mcnTextContentContainer">
                    <tbody><tr>
                        
                        <td valign="top" class="mcnTextContent" style="padding-top:9px; padding-right: 18px; padding-bottom: 9px; padding-left: 18px;">
                        
                            <em>Copyright 2015, Your D.O.S.T - IIT Guwahati, All rights reserved</em><br>
</td>
                    </tr>
                </tbody></table>
                
            </td>
        </tr>
    </tbody>
</table></td>
                                        </tr>
                                    </table>
									<!--[if gte mso 9]>
									</td>
									</tr>
									</table>
									<![endif]-->
                                    <!-- // END FOOTER -->
                                </td>
                            </tr>
						</table>
					
				
			
		</center>
	</div>
</body>
</html>