#ifndef CADMIUM_EXAMPLE_CELLDEVS_PEDESTRIANEVACUATION_STATE_HPP_
#define CADMIUM_EXAMPLE_CELLDEVS_PEDESTRIANEVACUATION_STATE_HPP_

#include <iostream>
#include <nlohmann/json.hpp>

namespace cadmium::celldevs::example::pedestrianEvacuation {

    //! State of the benchmark cell.
    struct PedestrianCell {
        int cellstate;
        int x;
        int y;
        int reached_exit;
        std::vector<std::vector<nlohmann::json>> exit_locations;
        std::vector<std::vector<nlohmann::json>> wall;
        
        //! Default constructor function.
        PedestrianCell() : cellstate(1), x(0), y(1), reached_exit(0) {
            exit_locations = {
                {{"x", 0}, {"y", 5}},
                {{"x", 9}, {"y", 5}}
            };
             wall = {
                {{"x", 5}, {"y", 5}}
            };
        }
    };

    //! Required for comparing states and detect any change.
    inline bool operator != (const PedestrianCell &x, const PedestrianCell &y) {
        return x.cellstate != y.cellstate || x.x != y.x || x.y != y.y ||x.reached_exit != y.reached_exit;
    }

    //! Required for printing the state of the cell.
    std::ostream &operator << (std::ostream &os, const PedestrianCell &x) {
        os << "<" << x.cellstate << ", " << x.x << ", " << x.y << ", " << x.reached_exit << ">";
        return os;
    }

    //! It parses a JSON file and generates the corresponding benchmark state object.
    [[maybe_unused]] void from_json(const nlohmann::json& j, PedestrianCell& s) {
        j.at("cellstate").get_to(s.cellstate);
        j.at("x").get_to(s.x);
        j.at("y").get_to(s.y);
        j.at("exit_locations").get_to(s.exit_locations);
        j.at("reached_exit").get_to(s.reached_exit);
        j.at("wall").get_to(s.wall);
    }

}   // namespace cadmium::celldevs::example::pedestrianEvacuation

#endif //CADMIUM_EXAMPLE_CELLDEVS_PEDESTRIANEVACUATION_STATE_HPP_
