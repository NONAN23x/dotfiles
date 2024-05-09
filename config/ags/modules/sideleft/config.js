const { Widget, App } = require('AylurAGS');

// Define the window that will be toggled
const leftBar = Widget.Window({
    name: 'leftbar', // Name the window for reference
    anchor: ['left'], // Anchor it to the left side of the screen
    child: Widget.Box({
        vertical: true, // Set to true if you want vertical alignment of children widgets
        children: [
            // Add child widgets here, such as labels, icons, etc.
            Widget.Label({
                label: 'Left Sidebar',
                class_name: 'sidebar-label'
            })
        ],
        class_name: 'left-sidebar', // Use this class for additional CSS styling
        css: 'padding: 20px; background-color: #333; color: white;' // Basic styling
    }),
    visible: false, // Initially hidden
    css: 'width: 200px; height: 100%;', // Set the width and full screen height
    keymode: "exclusive", // Capture keyboard inputs exclusively when visible
});

// Function to toggle the visibility of the left bar
function toggleLeftBar() {
    App.toggleWindow('leftbar');
}

// Export the setup if you need to use this elsewhere or need specific initial setup
module.exports = {
    setup: () => {
        // Setup key bindings or other initialization tasks
        leftBar.keybind("Escape", () => {
            App.closeWindow('leftbar');
        });
    },
    toggleLeftBar
};
