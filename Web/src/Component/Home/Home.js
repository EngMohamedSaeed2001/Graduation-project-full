import React, {useContext, useEffect, useState} from "react";
import '../../index.css';
import {Container} from "react-bootstrap";
import Header from "./Header";
import MiddleHome from "./MiddleHome";
import {BuildingContext} from "../../Context/BuildingContext";
import {UserContext} from "../../Context/UserContext";

let slider = [
    {
        img: "/images/slider/1.png",
        name: "1",
        id: 1
    },
    {
        img: "/images/slider/2.png",
        name: "2",
        id: 2
    },
    {
        img: "/images/slider/3.png",
        name: "3",
        id: 3
    },
    {
        img: "/images/slider/4.png",
        name: "4",
        id: 4
    }
]

const Home = () => {

    let {data,load}=useContext(BuildingContext)
let {ads}=useContext(UserContext)

    let d=[...ads]

    return (
        <Container fluid style={{paddingLeft: "0", paddingRight: "0"}}>
            <Header items={slider}  load={load}/>
            <MiddleHome items={data} ads={d}  load={load}/>
        </Container>
    );
}

export default Home;