using UnityEngine;
using System.Collections;
using System.Text;
using System.Net.Sockets;
using System.Threading;
using System.Net;
using LuaInterface;
using LuaUnity;

public class ThreadedLua : MonoBehaviour {
	
	private TcpListener tcpListener;
    private Thread listenThread;
	private static bool running;


	// Use this for initialization
	void Start () {
      this.tcpListener = new TcpListener(IPAddress.Any, 2020);
	  listenThread = new Thread(new ThreadStart(ListenForClients));
      listenThread.Start();	
	  Application.runInBackground = true;	
	}
	
	NetworkStream clientStream;
	ASCIIEncoding encoder = new ASCIIEncoding();
	string request;
	
    private void ListenForClients()  {
	  TcpClient client = null;
      tcpListener.Start();
      Debug.Log ("Up....!");
	  running = true;
	  try {
      	client = tcpListener.AcceptTcpClient();		
	  } catch {
		goto end;		
	  }
      while (running)  {      
        clientStream = client.GetStream();        
        
        byte[] message = new byte[4096];
        int bytesRead = 0;

         try {
          //blocks until a client sends a message
          bytesRead = clientStream.Read(message, 0, 4096);
         } catch {
          //a socket error has occured
		  Debug.Log ("socket read error");
          break;
         }

         if (bytesRead == 0) {
          //the client has disconnected from the server
          break;
         }
			
        //message has successfully been received

        request = encoder.GetString(message, 0, bytesRead);
        if (request == "quit\n")
            break;
      }
	end:
	  if (client != null) {		
      	client.Close();
	  	clientStream.Close ();
	  	clientStream = null;
	  }
      Debug.Log ("Down....!");			
    }	
	
	public void Write(string s) {
		if (clientStream == null) return;
		s = s.Replace('\n','\x02') + "\n";
        byte[] buffer = encoder.GetBytes(s);
        clientStream.Write(buffer, 0 , buffer.Length);
        clientStream.Flush();		
	}
	
	Lua L;
	LuaFunction collect_print;
	
	// Update is called once per frame
	void Update () {
		if (request != null) {
			string lua = request, result;
			request = null;
			if (L == null) {
				L = LuaMonoBehaviour.L;
				L.DoString("require 'interp'");
				collect_print = (LuaFunction)L["collect_print"];
			}
			try {
				L.DoString(lua);
				object[] res = collect_print.Call ();
				result = (string)res[0];
			} catch(System.Exception e) {				
				result = e.Message;
				//collect_print.Call ();
			}
			
			Write (result);
		}	
	}
	
	void OnDisable() {
		if (tcpListener != null) { // kill the server thread!
			running = false;
			tcpListener.Server.Close();
		}
	}
}
