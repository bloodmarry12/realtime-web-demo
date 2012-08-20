<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String serverUrl = request.getServerName()
			+ (request.getServerPort() == 80 ? "" : ":"
					+ request.getServerPort())
			+ request.getServletContext().getContextPath();
	request.setAttribute("serverUrl", serverUrl);
%>
<!DOCTYPE html>
<html>
<head>
<title>Web Socket Test</title>
</head>
<body>
	<script type="text/javascript">
		var socket;
		if (!window.WebSocket) {
			window.WebSocket = window.MozWebSocket;
		}
		if (window.WebSocket) {
			socket = new WebSocket("ws://${serverUrl}/websocket/tomcatWebsocket");
			socket.onmessage = function(event) {
				var ta = document.getElementById('responseText');
				ta.value = ta.value + '\n' + event.data
			};
			socket.onopen = function(event) {
				var ta = document.getElementById('responseText');
				ta.value = "Web Socket opened!";
			};
			socket.onclose = function(event) {
				var ta = document.getElementById('responseText');
				ta.value = ta.value + "Web Socket closed";
			};
		} else {
			alert("Your browser does not support Web Socket.");
		}

		function send(message) {
			if (!window.WebSocket) {
				return;
			}
			if (socket.readyState == WebSocket.OPEN) {
				socket.send(message);
			} else {
				alert("The socket is not open.");
			}
		}
	</script>
	<form onsubmit="return false;">
		<input type="text" name="message" value="Hello, World!" /><input
			type="button" value="Send Web Socket Data"
			onclick="send(this.form.message.value)" />
		<h3>Output</h3>
		<textarea id="responseText" style="width: 500px; height: 300px;"></textarea>
	</form>
</body>
</html>