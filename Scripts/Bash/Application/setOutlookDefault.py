
/usr/bin/python2.7 <<EOF
import LaunchServices;
result = LaunchServices.LSSetDefaultHandlerForURLScheme(
	"mailto",
	"com.microsoft.Outlook")
print("Result: %d (%s)" % (
	result,
	"Success" if result == 0 else "Error"))
EOF