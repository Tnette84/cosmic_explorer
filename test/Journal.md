```markdown
# Cosmic Explorer Development Journal

## Phase 1 – Communications Link
In Phase 1, I created two screens called Mission Control and Docking Bay. I used Navigator.push() to move from Mission Control to Docking Bay and Navigator.pop() to return to the previous screen.

When I enter Docking Bay, Flutter adds that screen to the navigation stack. When I return to Mission Control, Flutter removes Docking Bay from the stack.

I tested both navigation buttons, and they worked correctly.


## Phase 2 – Planetary Database

In Phase 2, I created a Planet class to store each planet's name, type, and description. I used ListView.builder to display five planets on the Mission Control screen.

ListView.builder helps organize the planet list by building items as needed instead of creating every item at once. I also used Navigator.push() to pass the selected Planet object to the PlanetDetail screen.

I tested all five planets and confirmed that their information displayed correctly. The Docking Bay navigation also worked.


## Phase 3 – Observation Log

In Phase 3, I added a Confirm Visit button to the PlanetDetail screen. I used Navigator.pop() to return a confirmation message to Mission Control.

I also used async and await to receive the message after returning from the planet screen. The ScaffoldMessenger displays the confirmation using a SnackBar.

This helped me understand how information can be passed back between screens. I tested the Confirm Visit button, and it worked correctly.