// Activate window

var topmost = null;
var order = -1;

for (let win of workspace.stackingOrder) {
  const x = win.frameGeometry.x;
  const y = win.frameGeometry.y;
  const width = win.frameGeometry.width;
  const height = win.frameGeometry.height;

  if (win.layer != 2 || win.minimized || win.deleted || (win.desktops.length != 0 && win.desktops.indexOf(workspace.currentDesktop) == -1)) continue;
  if (x >= workspace.workspaceWidth || y >= workspace.workspaceHeight || x + width <= 0 || y + height <= 0) continue;

  if (win.stackingOrder > order) {
    topmost = win;
    order = win.stackingOrder;
  }
}

if (topmost != null) {
  workspace.raiseWindow(topmost);
  workspace.activeWindow = topmost;
}
