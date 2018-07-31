Fatal/Critical: Overall application or system failure that should be investigated immediately. Yes, wake up the SysAdmin. Since we prefer our SysAdmins alert and well-rested, this severity should be used very infrequently. If it's happening daily and that's not a BFD, it's lost it's meaning. Typically, a Fatal error only occurs once in the process lifetime, so if the log file is tied to the process, this is typically the last message in the log.

Error: Definitely a problem that should be investigated. SysAdmin should be notified automatically, but doesn't need to be dragged out of bed. By filtering a log to look at errors and above you get an overview of error frequency and can quickly identify the initiating failure that might have resulted in a cascade of additional errors. Tracking error rates as versus application usage can yield useful quality metrics such as MTBF which can be used to assess overall quality. For example, this metric might help inform decisions about whether or not another beta testing cycle is needed before a release.

Warning: This MIGHT be problem, or might not. For example, expected transient environmental conditions such as short loss of network or database connectivity should be logged as Warnings, not Errors. Viewing a log filtered to show only warnings and errors may give quick insight into early hints at the root cause of a subsequent error. Warnings should be used sparingly so that they don't become meaningless. For example, loss of network access should be a warning or even an error in a server application, but might be just an Info in a desktop app designed for occassionally disconnected laptop users.

Info: This is important information that should be logged under normal conditions such as successful initialization, services starting and stopping or successful completion of significant transactions. Viewing a log showing Info and above should give a quick overview of major state changes in the process providing top-level context for understanding any warnings or errors that also occur. Don't have too many Info messages. We typically have < 5% Info messages relative to Trace.

Trace: Trace is by far the most commonly used severity and should provide context to understand the steps leading up to errors and warnings. Having the right density of Trace messages makes software much more maintainable but requires some diligence because the value of individual Trace statements may change over time as programs evolve. The best way to achieve this is by getting the dev team in the habit of regularly reviewing logs as a standard part of troubleshooting customer reported issues. Encourage the team to prune out Trace messages that no longer provide useful context and to add messages where needed to understand the context of subsequent messages. For example, it is often helpful to log user input such as changing displays or tabs.

Debug: We consider Debug < Trace. The distinction being that Debug messages are compiled out of Release builds. That said, we discourage use of Debug messages. Allowing Debug messages tends to lead to more and more Debug messages being added and none ever removed. In time, this makes log files almost useless because it's too hard to filter signal from noise. That causes devs to not use the logs which continues the death spiral. In contrast, constantly pruning Trace messages encourages devs to use them which results in a virtuous spiral. Also, this eliminates the possibility of bugs introduced because of needed side-effects in debug code that isn't included in the release build. Yeah, I know that shouldn't happen in good code, but better safe then sorry.


<table>
<tbody><tr>
<th>Value</th>
<th>Severity</th>
<th>Keyword</th>
<th>Deprecated keywords</th>
<th>Description</th>
</tr>
<tr>
<td>0</td>
<td>Emergency</td>
<td><code>emerg</code></td>
<td><code>panic</code></td>
<td>System is unusable.<br>
<p>A panic condition.</p>
</td>
</tr>
<tr>
<td>1</td>
<td>Alert</td>
<td><code>alert</code></td>
<td></td>
<td>Action must be taken immediately.<br>
<p>A condition that should be corrected immediately, such as a corrupted system database.</p>
</td>
</tr>
<tr>
<td>2</td>
<td>Critical</td>
<td><code>crit</code></td>
<td></td>
<td>Critical conditions, such as hard device errors.</td>
</tr>
<tr>
<td>3</td>
<td>Error</td>
<td><code>err</code></td>
<td><code>error</code></td>
<td>Error conditions.</td>
</tr>
<tr>
<td>4</td>
<td>Warning</td>
<td><code>warning</code></td>
<td><code>warn</code></td>
<td>Warning conditions.</td>
</tr>
<tr>
<td>5</td>
<td>Notice</td>
<td><code>notice</code></td>
<td></td>
<td>Normal but significant conditions.<br>
<p>Conditions that are not error conditions, but that may require special handling.</p>
</td>
</tr>
<tr>
<td>6</td>
<td>Informational</td>
<td><code>info</code></td>
<td></td>
<td>Informational messages.</td>
</tr>
<tr>
<td>7</td>
<td>Debug</td>
<td><code>debug</code></td>
<td></td>
<td>Debug-level messages.<br>
<p>Messages that contain information normally of use only when debugging a program.</p>
</td>
</tr>
</tbody></table>


## LOG4J
-  org.apache.log4j.Level  (https://www.tutorialspoint.com/log4j/log4j_logging_levels.htm)

<table class="table table-bordered">
<tbody><tr>
<th style="width:25%">Level</th>
<th>Description</th>
</tr>
<tr>
<td>ALL</td>
<td>All levels including custom levels.</td>
</tr>
<tr>
<td>DEBUG</td>
<td>Designates fine-grained informational events that are most useful to debug an application.</td>
</tr>
<tr>
<td>ERROR</td>
<td>Designates error events that might still allow the application to continue running.</td>
</tr>
<tr>
<td>FATAL</td>
<td>Designates very severe error events that will presumably lead the application to abort.</td>
</tr>
<tr>
<td>INFO</td>
<td>Designates informational messages that highlight the progress of the application at coarse-grained level.</td>
</tr>
<tr>
<td>OFF</td>
<td>The highest possible rank and is intended to turn off logging.</td>
</tr>
<tr>
<td>TRACE</td>
<td>Designates finer-grained informational events than the DEBUG.</td>
</tr>
<tr>
<td>WARN</td>
<td>Designates potentially harmful situations.</td>
</tr>
</tbody></table>

ALL < DEBUG < INFO < WARN < ERROR < FATAL < OFF


```java
import org.apache.log4j.*;

public class LogClass {
   private static org.apache.log4j.Logger log = Logger.getLogger(LogClass.class);
   
   public static void main(String[] args) {
      log.setLevel(Level.WARN);

      log.trace("Trace Message!");
      log.debug("Debug Message!");
      log.info("Info Message!");
      log.warn("Warn Message!");
      log.error("Error Message!");
      log.fatal("Fatal Message!");
   }
}
```

