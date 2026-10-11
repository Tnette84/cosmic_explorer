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