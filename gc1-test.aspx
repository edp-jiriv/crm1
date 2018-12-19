<!--
  Copyright (c) 2011 Google Inc.

  Licensed under the Apache License, Version 2.0 (the "License"); you may not
  use this file except in compliance with the License. You may obtain a copy of
  the License at

  http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
  WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
  License for the specific language governing permissions and limitations under
  the License.

  To run this sample, replace YOUR API KEY with your application's API key.
  It can be found at https://code.google.com/apis/console/?api=plus under API Access.
  Activate the Google+ service at https://code.google.com/apis/console/ under Services
-->
<!DOCTYPE html>
<html>
<head>
<meta charset='utf-8' />
</head>
<body>
 <!--Add a button for the user to click to initiate auth sequence -->
 <button id="authorize-button" style="visibility: hidden">Authorize</button>
 <button id="insert-button" style="visibility: hidden">Insert</button>
 <script type="text/javascript">
      // Enter a client ID for a web application from the Google Developer Console.
      // The provided clientId will only work if the sample is run directly from
      // https://google-api-javascript-client.googlecode.com/hg/samples/authSample.html
      // In your Developer Console project, add a JavaScript origin that corresponds to the domain
      // where you will be running the script.
      var clientId = '649152847109-kajbv2klm50ejkuj87e6or0u43m1gm68.apps.googleusercontent.com';

      // Enter the API key from the Google Developer Console - to handle any unauthenticated
      // requests in the code.
      // The provided key works for this sample only when run from
      // https://google-api-javascript-client.googlecode.com/hg/samples/authSample.html
      // To use in your own application, replace this API key with your own.
      var apiKey = 'AIzaSyBZ2SquATxkDWyCCqi8d6WDOahXtFj-NjE';

      // To enter one or more authentication scopes, refer to the documentation for the API.
      var scopes = 'https://www.googleapis.com/auth/calendar';
    
      // Use a button to handle authentication the first time.
	
      function handleClientLoad() {
        gapi.client.setApiKey(apiKey);
        window.setTimeout(checkAuth,2);
	alert("TEST");
      }
	

      function checkAuth() {
        gapi.auth.authorize({client_id: clientId, scope: scopes, immediate: true}, handleAuthResult);
      }


      function handleAuthResult(authResult) {
        if (authResult && !authResult.error) {
          makeApiCall();
        } else {
	  document.write("error");
        }
      }

      function handleAuthClick(event) {
        gapi.auth.authorize({client_id: clientId, scope: scopes, immediate: false}, handleAuthResult);
        return false;
      }
    
      function handleInsertClick(event) {
       makeInsertApiCall();
      }

      function makeApiCall() {
       gapi.client.load('calendar', 'v3', function() {
         var request = gapi.client.calendar.events.list({
           'calendarId': 'primary'
         });
              
         request.execute(function(resp) {
	/*
           for (var i = 0; i < resp.items.length; i++) {
             var li = document.createElement('li');
             li.appendChild(document.createTextNode(resp.items[i].start.dateTime + " " + resp.items[i].summary));
             document.getElementById('events').appendChild(li);
           }	
	*/
	//document.write("TEST");
	//alert("TEST");
	
           for (var i = 0; i < resp.items.length; i++) {
			 document.write(resp.items[i].start.dateTime + " " + resp.items[i].summary);
           }
	
         });
       });
     }

      function makeInsertApiCall() {
       gapi.client.load('calendar', 'v3', function() {
         var request = gapi.client.calendar.events.insert({
           "calendarId": "primary",
           resource:{
               "summary": "Testeintrag",
               "location": "Labor-HQ",
               "start": {
                 "dateTime": "2015-01-16T10:00:00.000+01:00"
               },
               "end": {
                 "dateTime": "2015-01-16T10:25:00.000+01:00"
               }
             }
         });
              
         request.execute(function(resp) {
           console.log(JSON.stringify(resp));
           //for (var i = 0; i < resp.items.length; i++) {
            // console.dir(resp);
           //}
         });
       });
     }
    
    </script>
 <script src="https://apis.google.com/js/client.js?onload=handleClientLoad"></script>
 <div id='content'>
  <h1>Events</h1>
  <ul id='events'></ul>
 </div>
 
 <p>Zugriff auf Google Calendar mit der Javascript Library.</p>
 </body>
</html>