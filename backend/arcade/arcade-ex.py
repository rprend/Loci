"""
Platformer Game
"""
import arcade

# Constants
SCREEN_WIDTH = 1610
SCREEN_HEIGHT = 850
SCREEN_TITLE = "Render"

# Constants used to scale our sprites from their original size
SPRITE_SCALING = 0.125


def read_sprite_list(grid, sprite_list):
    for row in grid:
        for grid_location in row:
            if grid_location.tile is not None:
                tile_sprite = arcade.Sprite("./" + grid_location.tile.source, SPRITE_SCALING)
                tile_sprite.center_x = grid_location.center_x * SPRITE_SCALING
                tile_sprite.center_y = grid_location.center_y * SPRITE_SCALING
                # print(f"{grid_location.tile.source} -- ({tile_sprite.center_x:4}, {tile_sprite.center_y:4})")
                sprite_list.append(tile_sprite)


class MyGame(arcade.Window):
    """
    Main application class.
    """

    def __init__(self):

        # Call the parent class and set up the window
        super().__init__(SCREEN_WIDTH, SCREEN_HEIGHT, SCREEN_TITLE)

        # These are 'lists' that keep track of our sprites. Each sprite should
        # go into a list.

        self.base_list = None
        self.roads_list = None
        self.trees_list = None
        self.buildings_list = None


        # Used to keep track of our scrolling
        self.view_bottom = 0
        self.view_left = 0

        self.my_map = None

    def setup(self):
        """ Set up the game here. Call this function to restart the game. """

        # --- Load in a map from the tiled editor ---

        # Name of map file to load
        map_name = "IsoMap.tmx"
        # Name of the base layer
        base_layer_name = 'Base Map'
        road_layer_name = 'Roads'
        tree_layer_name = 'Trees'
        building_layer_name = 'Buildings'


        self.base_list = arcade.SpriteList()
        self.roads_list = arcade.SpriteList()
        self.trees_list = arcade.SpriteList()
        self.buildings_list = arcade.SpriteList()


        # Read in the tiled map
        # my_map = arcade.tilemap.read_tmx(map_name)
        self.my_map = arcade.read_tiled_map(map_name, SPRITE_SCALING)


        read_sprite_list(self.my_map.layers[road_layer_name], self.roads_list)
        read_sprite_list(self.my_map.layers[tree_layer_name], self.roads_list)
        read_sprite_list(self.my_map.layers[building_layer_name], self.roads_list)

        # --- Other stuff
        # Set the background color
        if self.my_map.backgroundcolor:
            arcade.set_background_color(self.my_map.backgroundcolor) 

        # if self.my_map.backgroundcolor is None:
        #     arcade.set_background_color(arcade.color.BLACK)

        arcade.set_viewport(75, 1685, 35, 885)


    def on_draw(self):
        """ Render the screen. """

        # Clear the screen to the background color
        arcade.start_render()

        # Draw our sprites
        self.roads_list.draw()        
        self.trees_list.draw()        
        self.buildings_list.draw()

        image = arcade.get_image()
        image.save('screenshot.png', 'PNG') 

        exit()


def main():
    """ Main method """
    window = MyGame()
    window.setup()
    arcade.run()


if __name__ == "__main__":
    main()
