import React, {useContext, useState} from "react";
import '../../index.css';
import {Button, Card, Col, Container, Row, Spinner} from "react-bootstrap";
import "animate.css/animate.min.css";
import {useTranslation} from "react-i18next";
import {MdBed} from "react-icons/md";
import {FaBath, FaFilter, FaHeart} from "react-icons/fa";
import {BiArea} from "react-icons/bi";
import {GiSofa} from "react-icons/gi";
import {BsChatDots, BsEye, BsFillTelephoneFill} from "react-icons/bs";
import {ImWhatsapp} from "react-icons/im";
import copy from "copy-to-clipboard";
import Toast from "../../Helper/Toast";
import {NavLink, useParams} from "react-router-dom";
import {FiHeart} from "react-icons/fi";
import Load from "../../Helper/Load";
import Empty from "../../Helper/Empty";
import {BuildingContext} from "../../Context/BuildingContext";
import {UserContext} from "../../Context/UserContext";
import PropTypes from 'prop-types';
import AppBar from '@mui/material/AppBar';
import Box from '@mui/material/Box';
import CssBaseline from '@mui/material/CssBaseline';
import Divider from '@mui/material/Divider';
import Drawer from '@mui/material/Drawer';
import IconButton from '@mui/material/IconButton';
import List from '@mui/material/List';
import ListItem from '@mui/material/ListItem';
import Toolbar from '@mui/material/Toolbar';
import Navs from "../Navbar/Navs";
// import FilterRange from "./Filter/Filter";
import {Checkbox, FormControlLabel, FormGroup, InputLabel} from "@mui/material";

// import Sheet from '@mui/joy/Sheet';
import Slider from '@mui/material/Slider';


function valuetext(value) {
    return `${value}°C`;
}

const minDistance = 1;

const drawerWidth = 240;

function BuildingMenu(props) {
    let {load, data, filterData, makeFilter} = useContext(BuildingContext)
    let {ads} = useContext(UserContext)

    let d = [...ads]


    let {t} = useTranslation();
    let [loading, setLoading] = useState(false)
    let [fil, setFil] = useState(false)
    let [show, setShow] = useState(false)
    let [search, setSearch] = useState("")
    const [heart, setHeart] = useState(false);

    // Range
    let [value1, setValue1] = useState([0, 10000000]);
    let [value2, setValue2] = useState([0, 1000000]);
    let [value3, setValue3] = useState([0, 1000000]);
    let [value4, setValue4] = useState([0, 1000000]);
    let [value5, setValue5] = useState([0, 1000000]);

    let [minPrice, setMinPrice] = useState(0);
    let [maxPrice, setMaxPrice] = useState(10000000)
    let [minHall, setMinHall] = useState(0);
    let [maxHall, setMaxHall] = useState(4)
    let [minRooms, setMinRooms] = useState(0);
    let [maxRooms, setMaxRooms] = useState(7)
    let [minBathroom, setMinBathroom] = useState(0);
    let [maxBathroom, setMaxBathroom] = useState(4)
    let [minArea, setMinArea] = useState(50);
    let [maxArea, setMaxArea] = useState(1000)

    const handleChange1 = (event, newValue, activeThumb) => {
        if (!Array.isArray(newValue)) {
            return;
        }

        if (activeThumb === 0) {
            setValue1([Math.min(newValue[0], value1[1] - minDistance), value1[1]]);
            setMinPrice(Math.min(newValue[0], value1[1] - minDistance))
        } else {
            setValue1([value1[0], Math.max(newValue[1], value1[0] + minDistance)]);
            setMaxPrice(Math.max(newValue[1], value1[0] + minDistance))
        }
    };
    const handleChange2 = (event, newValue, activeThumb) => {
        if (!Array.isArray(newValue)) {
            return;
        }

        if (activeThumb === 0) {
            setValue2([Math.min(newValue[0], value2[1] - minDistance), value2[1]]);
            setMinHall(Math.min(newValue[0], value2[1] - minDistance))
        } else {
            setValue2([value2[0], Math.max(newValue[1], value2[0] + minDistance)]);
            setMaxHall(Math.max(newValue[1], value2[0] + minDistance))
        }
    };
    const handleChange3 = (event, newValue, activeThumb) => {
        if (!Array.isArray(newValue)) {
            return;
        }

        if (activeThumb === 0) {
            setValue3([Math.min(newValue[0], value3[1] - minDistance), value3[1]]);
            setMinBathroom(Math.min(newValue[0], value3[1] - minDistance))
        } else {
            setValue3([value3[0], Math.max(newValue[1], value3[0] + minDistance)]);
            setMaxBathroom(Math.max(newValue[1], value3[0] + minDistance))
        }
    };
    const handleChange4 = (event, newValue, activeThumb) => {
        if (!Array.isArray(newValue)) {
            return;
        }

        if (activeThumb === 0) {
            setValue4([Math.min(newValue[0], value4[1] - minDistance), value4[1]]);
            setMinRooms(Math.min(newValue[0], value4[1] - minDistance))
        } else {
            setValue4([value4[0], Math.max(newValue[1], value4[0] + minDistance)]);
            setMaxRooms(Math.max(newValue[1], value4[0] + minDistance))
        }
    };
    const handleChange5 = (event, newValue, activeThumb) => {
        if (!Array.isArray(newValue)) {
            return;
        }

        if (activeThumb === 0) {
            setValue5([Math.min(newValue[0], value5[1] - minDistance), value5[1]]);
            setMinArea(Math.min(newValue[0], value5[1] - minDistance))
        } else {
            setValue5([value5[0], Math.max(newValue[1], value5[0] + minDistance)]);
            setMaxArea(Math.max(newValue[1], value5[0] + minDistance))
        }
    };


    // filters

    let arr = []
    let [single, setSingle] = useState(false)
    let [business, setBusiness] = useState(false)
    let [apartment, setApartment] = useState(false)
    let [duplex, setDuplex] = useState(false)
    let [villa, setVilla] = useState(false)
    let [finished, setFinished] = useState(false)


    function Filter(bool) {



        let body = {
            "category": "",
            "city": "",
            "types": [],
            "minPrice": 0,
            "maxPrice": 0,
            "minArea": 0,
            "maxArea": 0,
            "minNumOfRoom": 0,
            "maxNumOfRoom": 0,
            "minNumOfBathroom": 0,
            "maxNumOfBathroom": 0,
            "minNumOfHalls": 0,
            "maxNumOfHalls": 0,
            "finished": false,
            "single": false,
            "acceptBusiness": false
        };

        if (bool) {
            if (apartment) {
                arr.push("apartment")
            } else {
                if (arr.includes("apartment")) {
                    arr = arr.filter((obj) => {
                        return (obj !== "apartment")
                    })
                }
            }

            if (villa) {
                arr.push("villa")
            } else {
                if (arr.includes("villa")) {
                    arr = arr.filter((obj) => {
                        return (obj !== "villa")
                    })
                }
            }

            if (duplex) {
                arr.push("duplex")
            } else {
                if (arr.includes("duplex")) {
                    arr = arr.filter((obj) => {
                        return (obj !== "duplex")
                    })
                }
            }

            body = {
                "category": "",
                "city": "",
                "types": arr,
                "minPrice": minPrice,
                "maxPrice": maxPrice,
                "minArea": minArea,
                "maxArea": maxArea,
                "minNumOfRoom": minRooms,
                "maxNumOfRoom": maxRooms,
                "minNumOfBathroom": minBathroom,
                "maxNumOfBathroom": maxBathroom,
                "minNumOfHalls": minHall,
                "maxNumOfHalls": maxHall,
                "finished": finished,
                "single": single,
                "acceptBusiness": business
            }
        }

        makeFilter(body)


        setLoading(false)
    }

    const {filter} = useParams();

    // let doFilter = () => {
    //
    //     if (filter.toString().toLowerCase() !== "all") {
    //         data = data.filter((obj) => {
    //             return (obj.category.toString().toLowerCase() === filter.toString().toLowerCase() ||
    //                 obj.city.toString().toLowerCase().includes(filter.toString().toLowerCase()) ||
    //                 obj.address.toString().toLowerCase().includes(filter.toString().toLowerCase())
    //                 || obj.price.toString().includes(filter.toString()))
    //         })
    //
    //
    //     }
    //
    // }

    // useEffect(() => {
    //
    //     doFilter()
    //
    // }, [])


    const copyToClipboard = (e) => {
        copy(e);
        setShow(true);
    }

    function sendWhatsApp(phone) {
        let number = phone.replace(/[^\w\s]/gi, "").replace(/ /g, "");
        let url = `https://web.whatsapp.com/send?phone=+20${number}&text=${encodeURI("Hi / مرحبا")}&app_absent=0`;
        window.open(url);
    }

    const {window} = props;
    const [mobileOpen, setMobileOpen] = React.useState(false);

    const handleDrawerToggle = () => {
        setMobileOpen(!mobileOpen);
    };


    const drawer = (
        <div>
            <Toolbar/>


            <input onChange={(e) => setSearch(e.target.value)} type={"search"}
                   placeholder={"Search by place, price, etc..."}
                   style={{borderRadius: "10px", padding: "8px", margin: "0 5px", width: "95%"}}/>

            <Divider/>

            <List>
                <ListItem disablePadding>
                    <Box sx={{width: 300, margin: "10px 20px"}}>
                        <InputLabel htmlFor="range-slider"
                                    style={{margin: "auto", textAlign: "center"}}>{t("price")}</InputLabel>
                        <Slider
                            getAriaLabel={() => 'Minimum distance'}
                            value={value1}
                            onChange={handleChange1}
                            valueLabelDisplay="auto"
                            getAriaValueText={valuetext}
                            disableSwap
                            min={0}
                            step={100000}
                            max={10000000}
                        />
                    </Box>
                </ListItem>

                <ListItem>
                    <Box sx={{width: 300, margin: "10px 20px"}}>
                        <InputLabel htmlFor="range-slider"
                                    style={{margin: "auto", textAlign: "center"}}>{t("halls")}</InputLabel>
                        <Slider
                            getAriaLabel={() => 'Minimum distance'}
                            value={value2}
                            onChange={handleChange2}
                            valueLabelDisplay="auto"
                            getAriaValueText={valuetext}
                            disableSwap
                            min={1}
                            step={1}
                            max={4}
                        />
                    </Box>
                </ListItem>

                <ListItem>
                    <Box sx={{width: 300, margin: "10px 20px"}}>
                        <InputLabel htmlFor="range-slider"
                                    style={{margin: "auto", textAlign: "center"}}>{t("bathroom")}</InputLabel>
                        <Slider
                            getAriaLabel={() => 'Minimum distance'}
                            value={value3}
                            onChange={handleChange3}
                            valueLabelDisplay="auto"
                            getAriaValueText={valuetext}
                            disableSwap
                            min={1}
                            step={1}
                            max={4}
                        />
                    </Box>
                </ListItem>

                <ListItem>
                    <Box sx={{width: 300, margin: "10px 20px"}}>
                        <InputLabel htmlFor="range-slider"
                                    style={{margin: "auto", textAlign: "center"}}>{t("rooms")}</InputLabel>
                        <Slider
                            getAriaLabel={() => 'Minimum distance'}
                            value={value4}
                            onChange={handleChange4}
                            valueLabelDisplay="auto"
                            getAriaValueText={valuetext}
                            disableSwap
                            min={1}
                            step={1}
                            max={7}
                        />
                    </Box>
                </ListItem>

                <ListItem>
                    <Box sx={{width: 300, margin: "10px 20px"}}>
                        <InputLabel htmlFor="range-slider"
                                    style={{margin: "auto", textAlign: "center"}}>{t("area")}</InputLabel>
                        <Slider
                            getAriaLabel={() => 'Minimum distance'}
                            value={value5}
                            onChange={handleChange5}
                            valueLabelDisplay="auto"
                            getAriaValueText={valuetext}
                            disableSwap
                            min={50}
                            step={10}
                            max={1000}
                        />
                    </Box>
                </ListItem>
            </List>

            <hr/>

            <FormGroup style={{marginLeft: "10px"}}>
                <InputLabel htmlFor="range-slider"
                            style={{margin: "10px", textAlign: "center", fontWeight: "bold"}}>{t("types")}</InputLabel>
                <FormControlLabel control={<Checkbox onClick={() => {
                    setApartment(!apartment)
                }}/>} label={t("apartment")}/>
                <FormControlLabel control={<Checkbox onClick={() => {
                    setDuplex(!duplex)
                }}/>} label={t("duplex")}/>
                <FormControlLabel control={<Checkbox onClick={() => {
                    setVilla(!villa)
                }}/>} label={t("villa")}/>
                <hr/>
                <FormControlLabel control={<Checkbox onClick={() => {
                    setFinished(!finished)
                }}/>} label={t("finished")}/>
                <FormControlLabel control={<Checkbox onClick={() => {
                    setSingle(!single)
                }}/>} label={t("single")}/>
                <FormControlLabel control={<Checkbox onClick={() => {
                    setBusiness(!business)
                }}/>} label={t("acceptBusiness")}/>
            </FormGroup>

            <Button style={{margin: "25px"}} className={"buttonSubmit"} onClick={() => {
                setLoading(true)
                setFil(true)
                Filter(true)
            }}>
                {
                    loading ?
                        <Spinner animation="border" size={"sm"} style={{color: "#ffffff", marginLeft: "8%"}}/> : ""
                }
                {t("done")}

            </Button>
            <Button style={{margin: "25px"}} className={"buttonSubmit"} onClick={() => {
                setFil(false)
                Filter(false)

            }}>{t("clear")}</Button>
        </div>
    );

    const container = window !== undefined ? () => window().document.body : undefined;

    return (
        <Box sx={{display: 'flex'}}>
            <CssBaseline/>
            <AppBar
                position="fixed"
                sx={{
                    width: {sm: `calc(100% - ${drawerWidth}px)`},
                    ml: {sm: `${drawerWidth}px`},
                    backgroundColor: "white",
                }}
            >
                <Toolbar>
                    <IconButton
                        color="black"
                        aria-label="open drawer"
                        edge="start"
                        onClick={handleDrawerToggle}
                        sx={{mr: 2, display: {sm: 'none'}}}
                    >
                        <FaFilter/>
                    </IconButton>

                    <Navs/>
                </Toolbar>
            </AppBar>
            <Box
                component="nav"
                sx={{width: {sm: drawerWidth}, flexShrink: {sm: 0}}}
                aria-label="mailbox folders"
            >
                {/* The implementation can be swapped with js to avoid SEO duplication of links. */}
                <Drawer
                    container={container}
                    variant="temporary"
                    open={mobileOpen}
                    onClose={handleDrawerToggle}
                    ModalProps={{
                        keepMounted: true, // Better open performance on mobile.
                    }}
                    sx={{
                        display: {xs: 'block', sm: 'none'},
                        '& .MuiDrawer-paper': {boxSizing: 'border-box', width: drawerWidth, overflowX: "hidden"},
                    }}

                >
                    {drawer}
                </Drawer>

                <Drawer
                    variant="permanent"
                    sx={{
                        display: {xs: 'none', sm: 'block'},
                        '& .MuiDrawer-paper': {boxSizing: 'border-box', width: drawerWidth, overflowX: "hidden"},
                    }}
                    open

                >

                    {drawer}
                </Drawer>
            </Box>
            <Box
                component="main"
                sx={{flexGrow: 1, p: 3, width: {sm: `calc(100% - ${drawerWidth}px)`}}}

            >

                <Container fluid className="header">


                    <Container>
                        <Row className={"content"}>
                            <h1 style={{
                                fontWeight: "bold",
                                fontFamily: "Avenir-Black",
                                fontSize: "49px",
                                color: "#000000"
                            }}>{t("headContent")}</h1>
                        </Row>


                        <Row className="content">

                            <Toast msg={t("copyMsg")} show={show} setShow={() => setShow(false)}/>
                            {
                                load ? (

                                        <Row xs={"auto"} lg={3} style={{alignItems: "center", alignContent: "center"}}>
                                            {
                                                data.length === 0 || (fil && filterData.length===0) ?  <Empty/>:
                                                    (
                                                        (fil ? filterData :
                                                                (
                                                                    filter.toString().toLowerCase() !== "all" ? (data.filter((obj) => {
                                                                                return (obj.category.toString().toLowerCase() === filter.toString().toLowerCase() ||
                                                                                    obj.city.toString().toLowerCase().includes(filter.toString().toLowerCase())
                                                                                    || obj.price.toString().includes(filter.toString()))
                                                                            })) : data
                                                                )
                                                        ).filter((ob) => {
                                                            return (ob.category.toString().toLowerCase().includes(search.toString().toLowerCase()) || ob.gov.toString().toLowerCase().includes(search.toString().toLowerCase())||
                                                                ob.city.toString().toLowerCase().includes(search.toString().toLowerCase()) || ob.price.toString().toLowerCase().includes(search.toString().toLowerCase())
                                                                || ob.area.toString().toLowerCase().includes(search.toString().toLowerCase()))
                                                        }).map(function (item, _) {
                                                            return (

                                                                <Col style={{margin: "auto"}} id={item.id} key={item.id}>

                                                                    <Card style={{width: "100%", maxWidth: '19rem'}}
                                                                          className={"item"}
                                                                          key={item.id}>
                                                                        <NavLink to={`/building/${item.id}`}
                                                                                 style={{textDecoration: "none", all: "unset"}}>
                                                                            <Card.Img variant="top" style={{width:"100%",height:"150px"}}
                                                                                      src={item.photosList[0]}/>

                                                                            <Card.Body>
                                                                                <Card.Title>
                                                                                    <h6>{item.price} EGP</h6>
                                                                                    <BsEye size={16}/> {item.views}
                                                                                </Card.Title>
                                                                                <Card.Text>
                                                                                    <p>{item.gov} , {item.city}</p>
                                                                                </Card.Text>

                                                                                <Card.Text>
                                                                                    <Row>
                                                                                        <Col>
                                                                                            <MdBed className={"item-icon"}/>
                                                                                            {item.numOfRoom}
                                                                                        </Col>
                                                                                        <Col>
                                                                                            <FaBath className={"item-icon"}/>
                                                                                            {item.numOfBathroom}
                                                                                        </Col>
                                                                                        <Col>
                                                                                            <BiArea className={"item-icon"}/>
                                                                                            {item.area}
                                                                                        </Col>
                                                                                        <Col>
                                                                                            <GiSofa className={"item-icon"}/>
                                                                                            {item.numOfHalls}
                                                                                        </Col>
                                                                                    </Row>
                                                                                </Card.Text>

                                                                            </Card.Body>
                                                                        </NavLink>

                                                                        {
                                                                            d.length > 0 ?
                                                                                d.map((it, _) => {

                                                                                    return (
                                                                                        it.user.userId === item.user.userId ? "" :
                                                                                            <Card.Footer>


                                                                                                <BsFillTelephoneFill
                                                                                                    className={"item-icon"}
                                                                                                    onClick={() => copyToClipboard(item.phone)}/>

                                                                                                <NavLink
                                                                                                    to={`/single-chat/${item.user.userId}/${item.user.username}`}>
                                                                                                    <BsChatDots
                                                                                                        className={"item-icon"}/>
                                                                                                </NavLink>
                                                                                                <ImWhatsapp style={{
                                                                                                    color: "#25d366",
                                                                                                    fontSize: "20px",
                                                                                                    marginLeft: "8px"
                                                                                                }}
                                                                                                            onClick={() => sendWhatsApp(item.phone)}/>

                                                                                                {
                                                                                                    heart === false ? <FiHeart
                                                                                                            className={"item-icon"}
                                                                                                            onClick={() => setHeart(true)}/> :
                                                                                                        <FaHeart
                                                                                                            className={"item-icon"}
                                                                                                            onClick={() => setHeart(false)}/>
                                                                                                }


                                                                                            </Card.Footer>
                                                                                    )

                                                                                    // eslint-disable-next-line no-unused-expressions


                                                                                })
                                                                                :
                                                                                <Card.Footer>

                                                                                    <BsFillTelephoneFill className={"item-icon"}
                                                                                                         onClick={() => copyToClipboard(item.phone)}/>

                                                                                    <NavLink
                                                                                        to={`/single-chat/${item.user.userId}/${item.user.username}`}>
                                                                                        <BsChatDots className={"item-icon"}/>
                                                                                    </NavLink>
                                                                                    <ImWhatsapp style={{
                                                                                        color: "#25d366",
                                                                                        fontSize: "20px",
                                                                                        marginLeft: "8px"
                                                                                    }}
                                                                                                onClick={() => sendWhatsApp(item.phone)}/>


                                                                                </Card.Footer>
                                                                        }

                                                                    </Card>

                                                                </Col>

                                                            )
                                                        })
                                                    )
                                            }
                                        </Row>


                                    ) :
                                    <Load
                                        style={{width: "80px", height: "80px", margin: "auto"}}/>
                            }

                        </Row>

                    </Container>

                </Container>


            </Box>
        </Box>
    );
}

BuildingMenu.propTypes = {
    /**
     * Injected by the documentation to work in an iframe.
     * You won't need it on your project.
     */
    window: PropTypes.func,
};

export default BuildingMenu;