package net.nyx.nyxprinter.nyx_printer;

import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.ServiceConnection;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Handler;
import android.os.IBinder;
import android.os.RemoteException;
import androidx.annotation.NonNull;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import net.nyx.printerservice.print.IPrinterService;
import net.nyx.printerservice.print.PrintTextFormat;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

/** NyxPrinterPlugin */
public class NyxPrinterPlugin implements FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;
  private IPrinterService printerService;
  private Context appContext;
  String[] version = new String[1];
  private ExecutorService singleThreadExecutor = Executors.newSingleThreadExecutor();
  private Handler handler = new Handler();

  private final ServiceConnection connService = new ServiceConnection() {
    @Override
    public void onServiceDisconnected(ComponentName name) {
      printerService = null;
      handler.postDelayed(() -> startService(appContext), 5000);
    }

    @Override
    public void onServiceConnected(ComponentName name, IBinder service) {
      printerService = IPrinterService.Stub.asInterface(service);
    }
  };

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    appContext = flutterPluginBinding.getApplicationContext();
    startService(flutterPluginBinding.getApplicationContext());
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "nyx_printer");
    channel.setMethodCallHandler(this);
  }


  private void startService(@NonNull Context context) {
    Intent intent = new Intent();
    intent.setPackage("net.nyx.printerservice");
    intent.setAction("net.nyx.printerservice.IPrinterService");
    context.bindService(intent, this.connService, Context.BIND_AUTO_CREATE);
  }

  private void stopService(@NonNull Context context) {
    context.unbindService(this.connService);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("getVersion")) {
      try {
        int ret = printerService.getPrinterVersion(version);
        result.success(ret);
      } catch (RemoteException e) {
        result.success(404);
      }
    } else if (call.method.equals("printText")) {
      try {
        PrintTextFormat textFormat = new PrintTextFormat();
        textFormat.setAli(call.argument("align"));
        textFormat.setTextSize(call.argument("textSize"));
        textFormat.setUnderline(call.argument("underline"));
        textFormat.setTextScaleX(new Double(call.argument("textScaleX").toString()).floatValue());
        textFormat.setTextScaleY(new Double(call.argument("textScaleY").toString()).floatValue());
        textFormat.setLetterSpacing(new Double(call.argument("letterSpacing").toString()).floatValue());
        textFormat.setLineSpacing(new Double(call.argument("lineSpacing").toString()).floatValue());
        textFormat.setTopPadding(call.argument("topPadding"));
        textFormat.setLeftPadding(call.argument("leftPadding"));
        textFormat.setStyle(call.argument("style"));
        textFormat.setFont(call.argument("font"));
        int ret = printerService.printText(call.argument("text").toString(), textFormat);
        if (ret == 0) {
          paperOutText(call.argument("textSize"));
          result.success(ret);
        } else {
          result.success(ret);
        }
      } catch (RemoteException e) {
        result.success(404);
      }
    } else if (call.method.equals("printBarcode")) {
      try {
        int ret = printerService.printBarcode(call.argument("text").toString(), call.argument("width"), call.argument("height"), 1, 1);
        if (ret == 0) {
          paperOut();
          result.success(ret);
        } else {
          result.success(ret);
        }
      } catch (RemoteException e) {
        result.success(404);
      }
    } else if (call.method.equals("printQrCode")) {
      try {
        int ret = printerService.printQrCode(call.argument("text").toString(), call.argument("width"), call.argument("height"), 1);
        if (ret == 0) {
          paperOut();
          result.success(ret);
        } else {
          result.success(ret);
        }
      } catch (RemoteException e) {
        result.success(404);
      }
    } else if (call.method.equals("printBitmap")) {
      try {
        ByteArrayInputStream arrayInputStream = new ByteArrayInputStream(call.argument("bytes"));
        Bitmap decoded = BitmapFactory.decodeStream(arrayInputStream);
        ByteArrayOutputStream stream = new ByteArrayOutputStream();
        decoded.compress(Bitmap.CompressFormat.PNG, 100, stream);
        int ret = printerService.printBitmap(decoded, 1, 1);
        if (ret == 0) {
          paperOut();
          result.success(ret);
        } else {
          result.success(ret);
        }
      } catch (RemoteException e) {
        result.success(404);
      }
    }
  }

  private void paperOut() {
    singleThreadExecutor.submit(new Runnable() {
      @Override
      public void run() {
        try {
          printerService.paperOut(80);
        } catch (RemoteException e) {
          e.printStackTrace();
        }
      }
    });
  }

  private void paperOutText(int size) {
    singleThreadExecutor.submit(new Runnable() {
      @Override
      public void run() {
        try {
          printerService.paperOut(size);
        } catch (RemoteException e) {
          e.printStackTrace();
        }
      }
    });
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    stopService(binding.getApplicationContext());
    channel.setMethodCallHandler(null);
  }
}
