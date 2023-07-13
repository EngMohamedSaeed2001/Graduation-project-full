import React, {createContext, useEffect, useState} from 'react';
import api from "../Apis/Base";

export const BuildingContext = createContext();

export const BuildingProvider = ({ children }) => {

   const [load, setLoad] = useState(false);
    let [data, setData] = useState([])
    let [filterData, setFilterData] = useState([])


   let [flatImage,setFlatImage]=useState([])
    let [image, setImage] = useState("https://firebasestorage.googleapis.com/v0/b/semsark-529c0.appspot.com/o/usersImages%2Favatar.png?alt=media&token=7ff7547a-06ca-4666-a4d7-134566917f3a");
    let [username, setUsername] = useState("");
    let [userId, setUserId] = useState("");
    let [phone, setPhone] = useState("");
    let [signalPower, setSignalPower] = useState("");
    let [title, setTitle] = useState("");
    let [category, setCategory] = useState("");
    let [address, setAddress] = useState("");
    let [city, setCity] = useState("");
    let [gov, setGov] = useState("");
    let [date, setDate] = useState("");
    let [des, setDes] = useState("");
    let [types, setTypes] = useState("");
    let [price, setPrice] = useState(0);
    let [area, setArea] = useState(0);
    let [numOfHalls, setNumOfHalls] = useState(0);
    let [numOfBathroom, setNumOfBathroom] = useState(0);
    let [numOfRoom, setNumOfRoom] = useState(0);
    let [single, setSingle] = useState(0);
    let [finished, setFinished] = useState(0);
    let [views, setViews] = useState(0);
    let [level, setLevel] = useState(0);

    const [heart, setHeart] = useState(false);
    let [lat, setLat] = useState("30.033333")
    let [long, setLong] = useState("31.233334")
    let [email, setEmail] = useState("");
    let [loadBuilding, setLoadBuilding] = useState(false)


    const getBuildings = () => {
        api.api.get("common/getAllAds").then((res) => {
            if (res.status === 200) {
                setLoad(true)

                setData(res.data)


            }
        }).catch((e) => {
            console.log(e)
        })
    }

     const getBuilding = (id) => {
        api.apiToken.get(`user/building/${id}`).then((res) => {
            if (res.status === 200) {
                setLoadBuilding(true)
                setEmail(res.data.user.email)
                setUserId(res.data.user.userId)
                setUsername(res.data.user.username)
                setPhone(res.data.user.phone)

                if (res.data.user.img !== '' && res.data.user.img !== 'string') {
                    setImage(res.data.user.img)
                }
                setViews(res.data.views)
                setLevel(res.data.level)
                setArea(res.data.area)
                setNumOfHalls(res.data.numOfHalls)
                setNumOfBathroom(res.data.numOfBathroom)
                setNumOfRoom(res.data.numOfRoom)
                setPrice(res.data.price)
                setLong(res.data.lng)
                setLat(res.data.lat)
                setAddress(res.data.address)
                setDate(res.data.date)
                setCategory(res.data.category)
                setCity(res.data.city)
                setGov(res.data.gov)
                setFinished(res.data.finished)
                setDes(res.data.apartmentDetails)
                setSignalPower(res.data.signalPower)
                setSingle(res.data.single)
                setTypes(res.data.types)
                setTitle(res.data.title)

                setFlatImage(res.data.photosList)


            }
        }).catch((e) => {
            console.log(e)
            setLoad(false)
        })
    }

    const getFav = (id) => {

        api.apiToken.get(`user/getMyFavouriteById/${id}`).then((res) => {
            if (res.status === 200) {

                    setHeart(true)

            } else {
                setHeart(false)
            }
        }).catch((e) => {
            console.log(e)
            setHeart(false)
        })
    }

    let makeFilter = (body) => {

        api.apiToken.post(`user/filter`, body).then((res) => {
            if (res.status === 200) {
                setFilterData(res.data)
            }
        }).catch((e) => {
            console.log(e)
        })
    }

    useEffect(() => {
        getBuildings()
    }, [])


    return (
        <BuildingContext.Provider value={{
            makeFilter,
            getBuilding,
            getFav,
            filterData,
            data,
            load,
            loadBuilding,
            username,
            image,
            flatImage,
            email,
            long,
            lat,
            heart,
            level,
            views,
            finished,
            single,
            numOfRoom,
            numOfBathroom,
            numOfHalls,
            area,
            price,
            types,
            des,
            date,
            gov,
            city,
            address,
            category,
            title,
            signalPower,
            phone,
            userId
        }}>
            {children}
        </BuildingContext.Provider>
    );
};
