@routing @bearing @testbot
Feature: Compass bearing

    Background:
        Given the profile "testbot"

    Scenario: Bearing when going northwest
        Given the node map
            | b |   |
            |   | a |

        And the ways
            | nodes |
            | ab    |

        When I route I should get
            | from | to | route    | bearing   |
            | a    | b  | ab,ab    | 315,0     |

    Scenario: Bearing when going west
        Given the node map
            | b | a |

        And the ways
            | nodes |
            | ab    |

        When I route I should get
            | from | to | route    | bearing |
            | a    | b  | ab,ab    | 270,0   |

    Scenario: Bearing af 45 degree intervals
        Given the node map
            | b | a | h |
            | c | x | g |
            | d | e | f |

        And the ways
            | nodes |
            | xa    |
            | xb    |
            | xc    |
            | xd    |
            | xe    |
            | xf    |
            | xg    |
            | xh    |

        When I route I should get
            | from | to | route    | bearing |
            | x    | a  | xa,xa    | 0,0     |
            | x    | b  | xb,xb    | 315,0   |
            | x    | c  | xc,xc    | 270,0   |
            | x    | d  | xd,xd    | 225,0   |
            | x    | e  | xe,xe    | 180,0   |
            | x    | f  | xf,xf    | 135,0   |
            | x    | g  | xg,xg    | 90,0    |
            | x    | h  | xh,xh    | 45,0    |

    Scenario: Bearing in a roundabout
        Given the node map
            |   | d | c |   |
            | e |   |   | b |
            | f |   |   | a |
            |   | g | h |   |

        And the ways
            | nodes | oneway |
            | ab    | yes    |
            | bc    | yes    |
            | cd    | yes    |
            | de    | yes    |
            | ef    | yes    |
            | fg    | yes    |
            | gh    | yes    |
            | ha    | yes    |

        When I route I should get
            | from | to | route                   | bearing                   |
            | c    | b  | cd,de,ef,fg,gh,ha,ab,ab | 270,225,180,135,90,45,0,0 |
            | g    | f  | gh,ha,ab,bc,cd,de,ef,ef | 90,45,0,315,270,225,180,0 |

    Scenario: Bearing should stay constant when zig-zagging
        Given the node map
            | b | d | f | h |
            | a | c | e | g |

        And the ways
            | nodes |
            | ab    |
            | bc    |
            | cd    |
            | de    |
            | ef    |
            | fg    |
            | gh    |

        When I route I should get
            | from | to | route                   | bearing               |
            | a    | h  | ab,bc,cd,de,ef,fg,gh,gh | 0,135,0,135,0,135,0,0 |

    Scenario: Bearings on an east-west way.
        Given the node map
            | a | b | c | d | e | f |

        And the ways
            | nodes  |
            | abcdef |

        When I route I should get
            | from | to | route         | bearing |
            | a    | b  | abcdef,abcdef | 90,0    |
            | a    | c  | abcdef,abcdef | 90,0    |
            | a    | d  | abcdef,abcdef | 90,0    |
            | a    | e  | abcdef,abcdef | 90,0    |
            | a    | f  | abcdef,abcdef | 90,0    |
            | b    | a  | abcdef,abcdef | 270,0   |
            | b    | c  | abcdef,abcdef | 90,0    |
            | b    | d  | abcdef,abcdef | 90,0    |
            | b    | e  | abcdef,abcdef | 90,0    |
            | b    | f  | abcdef,abcdef | 90,0    |
            | c    | a  | abcdef,abcdef | 270,0   |
            | c    | b  | abcdef,abcdef | 270,0   |
            | c    | d  | abcdef,abcdef | 90,0    |
            | c    | e  | abcdef,abcdef | 90,0    |
            | c    | f  | abcdef,abcdef | 90,0    |
            | d    | a  | abcdef,abcdef | 270,0   |
            | d    | b  | abcdef,abcdef | 270,0   |
            | d    | c  | abcdef,abcdef | 270,0   |
            | d    | e  | abcdef,abcdef | 90,0    |
            | d    | f  | abcdef,abcdef | 90,0    |
            | e    | a  | abcdef,abcdef | 270,0   |
            | e    | b  | abcdef,abcdef | 270,0   |
            | e    | c  | abcdef,abcdef | 270,0   |
            | e    | d  | abcdef,abcdef | 270,0   |
            | e    | f  | abcdef,abcdef | 90,0    |
            | f    | a  | abcdef,abcdef | 270,0   |
            | f    | b  | abcdef,abcdef | 270,0   |
            | f    | c  | abcdef,abcdef | 270,0   |
            | f    | d  | abcdef,abcdef | 270,0   |
            | f    | e  | abcdef,abcdef | 270,0   |

    Scenario: Bearings at high latitudes
    # The coordinas below was calculated using http://www.movable-type.co.uk/scripts/latlong.html,
    # to form square with sides of 1 km.

        Given the node locations
            | node | lat       | lon      |
            | a    | 80        | 0        |
            | b    | 80.006389 | 0        |
            | c    | 80.006389 | 0.036667 |
            | d    | 80        | 0.036667 |

        And the ways
            | nodes |
            | ab    |
            | bc    |
            | cd    |
            | da    |
            | ac    |
            | bd    |

        When I route I should get
            | from | to | route | bearing |
            | a    | b  | ab,ab | 0,0     |
            | b    | c  | bc,bc | 90,0    |
            | c    | d  | cd,cd | 180,0   |
            | d    | a  | da,da | 270,0   |
            | b    | a  | ab,ab | 180,0   |
            | c    | b  | bc,bc | 270,0   |
            | d    | c  | cd,cd | 0,0     |
            | a    | d  | da,da | 90,0    |
            | a    | c  | ac,ac | 45,0    |
            | c    | a  | ac,ac | 225,0   |
            | b    | d  | bd,bd | 135,0   |
            | d    | b  | bd,bd | 315,0   |

    Scenario: Bearings at high negative latitudes
    # The coordinas below was calculated using http://www.movable-type.co.uk/scripts/latlong.html,
    # to form square with sides of 1 km.

        Given the node locations
            | node | lat        | lon      |
            | a    | -80        | 0        |
            | b    | -80.006389 | 0        |
            | c    | -80.006389 | 0.036667 |
            | d    | -80        | 0.036667 |

        And the ways
            | nodes |
            | ab    |
            | bc    |
            | cd    |
            | da    |
            | ac    |
            | bd    |

        When I route I should get
            | from | to | route  | bearing |
            | a    | b  | ab,ab  | 180,0   |
            | b    | c  | bc,bc  | 90,0    |
            | c    | d  | cd,cd  | 0,0     |
            | d    | a  | da,da  | 270,0   |
            | b    | a  | ab,ab  | 0,0     |
            | c    | b  | bc,bc  | 270,0   |
            | d    | c  | cd,cd  | 180,0   |
            | a    | d  | da,da  | 90,0    |
            | a    | c  | ac,ac  | 135,0   |
            | c    | a  | ac,ac  | 315,0   |
            | b    | d  | bd,bd  | 45,0    |
            | d    | b  | bd,bd  | 225,0   |
