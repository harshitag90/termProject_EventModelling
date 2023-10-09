#ifndef CADMIUM_EXAMPLE_CELLDEVS_Pedestrian_CELL_HPP_
#define CADMIUM_EXAMPLE_CELLDEVS_Pedestrian_CELL_HPP_

#include <cmath>
#include <nlohmann/json.hpp>
#include <cadmium/celldevs/grid/cell.hpp>
#include <cadmium/celldevs/grid/config.hpp>
#include "state.hpp"

namespace cadmium::celldevs::example::pedestrianEvacuation {
	//! Synthetic pedestrianEvacuation cell.
	class GridPedestrianCell : public GridCell<PedestrianCell, double> {
		double cellstate;
		double exit_locations;
		double wall;
		double x;
		double y;
			
	 public:
		GridPedestrianCell(const std::vector<int>& id, const std::shared_ptr<const GridCellConfig<PedestrianCell, double>>& config):
		  GridCell<PedestrianCell, double>(id, config), cellstate() , exit_locations(), wall(), x(), y() {}

		[[nodiscard]] PedestrianCell localComputation(PedestrianCell state,
		  const std::unordered_map<std::vector<int>, NeighborData<PedestrianCell, double>>& neighborhood) const override {
	 switch (state.cellstate) {
        case 1: // Pedestrian moving upwards
            state.y -= 1;
            if (hasReachedExit(state)) {
                state.reached_exit=1;
                state.cellstate=0;
            } 
            else if (hasHitWall(state)) {
                 state.cellstate = 3; // Turn left
            }
            break;
        case 2: // Pedestrian moving downwards
            state.y += 1;
            if (hasReachedExit(state)) {
                state.reached_exit=1;
                state.cellstate=0;
            } 
            else if (hasHitWall(state)) {
                state.cellstate = 4; // Turn right
            }
            break;
        case 3: // Pedestrian moving left after hitting a wall
            state.x -= 1;
            if (hasReachedExit(state)) {
                state.reached_exit=1;
                state.cellstate=0;
            } 
            else if (!hasHitWall(state)) {
                state.cellstate = 1; // Continue moving upwards
            }
            break;
        case 4: // Pedestrian moving right after hitting a wall
            state.x += 1;
            if (hasReachedExit(state)) {
                state.reached_exit=1;
                state.cellstate=0;
            } 
            else if (!hasHitWall(state)) {
                state.cellstate = 2; // Continue moving downwards
            }
            break;
        default:
            break;
    }
			return state;
		}
 // Check if pedestrian has found an exit
   bool hasReachedExit(const PedestrianCell state) const {
    for (const auto& exit_loc : state.exit_locations) {
    int exit_x = exit_loc[0]["x"].get<int>();
    int exit_y = exit_loc[0]["y"].get<int>();
    if (state.x == exit_x && state.y == exit_y) {
		return true;
        }
    }
    return false;
}

// Check if a wall is present
bool hasHitWall(const PedestrianCell state) const {
    for (const auto& wall : state.wall) {
         int wallX = wall[0]["x"].get<int>();
         int wallY = wall[0]["y"].get<int>();
        if (state.x == wallX && state.y == wallY) {
            return true;
        }
    }
    return false;
}
		[[nodiscard]] double outputDelay(const PedestrianCell& cellstate) const override {
			return 1;
		}
	};
}  //namespace admium::celldevs::example::pedestrianEvacuation

#endif //CADMIUM_EXAMPLE_CELLDEVS_Pedestrian_CELL_HPP_
