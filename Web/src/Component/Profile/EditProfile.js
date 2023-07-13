import React, {useContext, useEffect, useState} from "react";
import '../../index.css';
import {Button, Col, Container, FloatingLabel, Form, Image, Row, Spinner} from "react-bootstrap";
import {Formik} from 'formik';
import {bool, number, object, string} from 'yup';
import {FcOldTimeCamera} from "react-icons/fc";
import validator from "validator";
import {createDefaultMaskGenerator, MaskedInput} from 'react-hook-mask';
import {storage} from "../../Apis/firebase";
import {getDownloadURL, ref, uploadBytesResumable} from "firebase/storage";
import Load from "../../Helper/Load";
import {useTranslation} from "react-i18next";
import ToastMsg from "../../Helper/Toast";
import i18n from '../Navbar/i18n'
import api from "../../Apis/Base";
import {Navigate} from "react-router-dom";
import {UserContext} from "../../Context/UserContext";

const maskGenerator = createDefaultMaskGenerator('+20 999 999 9999');

const schema = object({
    username: string(),
    email: string(),
    phone: number(),
    terms: bool().required().oneOf([true], 'terms must be accepted'),
});

let url = "";
let oldEmail = `${localStorage.getItem("user_email")}`;
let lg;

const EditProfile = (props) => {
    const {image,load,username,email,phone1,gen,user}=useContext(UserContext);

    let {t} = useTranslation();
    let [image1, setImage1] = useState(image)
    let [upload, setUpload] = useState(false);
    let [complete, setComplete] = useState(false);
    let [fullname, setFullname] = useState(null);
    let [phone, setPhone] = useState("");
    let [gender, setGender] = useState("");
    let [password, setPassword] = useState("");
    let [loadButton, setLoadButton] = useState(true);
    let [wait, setWait] = useState(false);
    let [hide, setHide] = useState(false);
    let [msg, setMsg] = useState("");


    const imageChange = (e) => {
        if (fullname.length > 0) {
            const img = e.target.files[0];
            setImage1(URL.createObjectURL(img));



            if (!img) return

            uploadImage(img)
        } else {
            setMsg(t("completeYourData"))
            setHide(true)
        }
    }

    function uploadImage(file) {
        setUpload(true)
        setComplete(true)
        let storageRef = ref(storage, `usersImages/${fullname}`);

        let uploadTask = uploadBytesResumable(storageRef, file);

        uploadTask.on("state_changed",
            (snapshot) => {
                const progress =
                    Math.round((snapshot.bytesTransferred / snapshot.totalBytes) * 100);
                console.log(progress)
            },
            (error) => {
                alert(error);
            },
            () => {
                setUpload(false)
                getDownloadURL(uploadTask.snapshot.ref).then((downloadURL) => {
                    url = downloadURL;
                    setImage1(url)
                    setComplete(false)

                });
            }
        );



    }



    const updateProfile = () => {

        api.apiToken.patch("insecure/userDetails/updateUser", {
            username: fullname,
            password: password,
            phone: phone,
            gender: gender,
            img: image1
        }).then((res) => {
            if (res.status === 200) {
                setWait(true)
                setLoadButton(true)
                localStorage.setItem("user_email", email === "" ? oldEmail : email)
                setMsg(t("done"))
                setHide(true)
            }
        }).catch((e) => {
            console.log(e)
            setLoadButton(true)
        })
    }

    useEffect(() => {
        lg = localStorage.getItem("lg")
    }, [])


    const addUser = () => {

        api.api.post("insecure/userDetails", {
            email: email||oldEmail,
            phone:phone,
            username: fullname,
            gender: gender,
            img: image1,
            password: password,
            social: false
        }).then((res) => {

            if (res.status === 200) {
                setWait(true);
                setLoadButton(true)
                localStorage.setItem("user_token", res.data.token)
                localStorage.setItem("set_auth", 'true')
                setMsg(t("done"))
                setHide(true)
                localStorage.removeItem("lg");
            }

        }).catch((e) => {

            setMsg(e.response.data.message)
            setHide(true)
            setLoadButton(true)
        })
    }


    if (wait && !user) {
        return <Navigate to={'/'}/>
    }

    return (
        <Container fluid style={{backgroundColor: "#f1f2f4"}}>
            <Formik
                validationSchema={schema}
                onSubmit={console.log}
                initialValues={{

                    email: email ,
                    username: username ,
                    password: '',
                    confirmPassword: '',
                    gender: gender ,
                    terms: false,
                }}
            >
                {({
                      handleSubmit,
                      handleChange,
                      handleBlur,
                      values,
                      touched,
                      isValid,
                      errors,
                  }) => (

                    load||lg==="true" ?
                        (
                            <Container fluid style={{padding: "30px"}}>
                                <Container fluid style={{padding:"20px"}}>
                                    <h3 style={{
                                    textAlign: (i18n.language === 'en' ? "left" : "right"),
                                    color: "#3E435D",
                                    margin: " 5% 0%",
                                    fontFamily: "Poppins-Medium",
                                    fontSize: "28px"
                                }}>{t("welcome")}{fullname === null ? username : fullname}</h3>
                                    <Row xs={2} >
                                        <Col style={{
                                            textAlign: (i18n.language === 'en' ? "left" : "right"),
                                            marginLeft: "0%",
                                            marginTop:"21px"
                                        }}>
                                            {upload === false && complete === false ?
                                                <Image width={"120px"} height={"120px"} roundedCircle
                                                       src={url === "" ? image1 : url}/>
                                                :
                                                <Spinner animation="grow" size={"lg"}
                                                         style={{color: "#0091FF", marginLeft: "8%"}}/>
                                            }


                                            <p style={{marginLeft: "11%", marginTop: "-3%"}}>
                                                <input accept="image/*" id="icon-button-file" onChange={imageChange}
                                                       type="file" style={{display: 'none'}}/>
                                                <label htmlFor="icon-button-file">
                                                    <FcOldTimeCamera cursor="pointer" size={30}/>
                                                </label>
                                            </p>
                                        </Col>

                                        <Col style={{
                                            float:"left",
                                            marginLeft: (i18n.language === 'en' ? "10rem" : "0"),
                                            marginRight: (i18n.language === 'ar' ? "10rem" : "0"),
                                            marginTop: "-6rem",
                                            textAlign: (i18n.language === 'en' ? "left" : "right")
                                        }}>
                                            <h5 style={{
                                                color: "#000000",
                                                fontFamily: "Poppins-Medium",
                                                fontSize: "23px",
                                                fontWeight:"bold"
                                            }}>{fullname === null ? username : fullname}</h5>
                                            <h6 style={{
                                                color: "#000000",
                                                opacity: "0.5",
                                                fontFamily: "Poppins-Regular",
                                                fontSize: "17px",
                                                wordBreak:"break-word"
                                            }}>{email||oldEmail}</h6>
                                        </Col>

                                    </Row>

                                    <Row xs={"auto"} lg={2} md={1} sm={1}  style={{marginTop: "5%"}}>
                                    <Col >
                                        <Form noValidate onSubmit={onsubmit}>
                                            <Row className="inputs">
                                                <FloatingLabel controlId="floatingUsername" className="label"
                                                               label={t("fullName")}>
                                                    <Form.Control
                                                        className={"field"}
                                                        type="text"
                                                        placeholder={t("fullName")}
                                                        aria-describedby="inputGroupPrepend"
                                                        name="username"
                                                        value={fullname===null&& username!==null?username:values.username}
                                                        onChange={handleChange}
                                                        isInvalid={!values.username && !username}
                                                        aria-required={true}
                                                    />
                                                    <Form.Control.Feedback type="invalid" tooltip>
                                                         {t("requiredField")}
                                                    </Form.Control.Feedback>
                                                    {setFullname(values.username)}
                                                </FloatingLabel>

                                            </Row>

                                            <Row className="inputs">
                                                <FloatingLabel controlId="floatingPassword" className="label"
                                                               label={t("enterPassword")}>
                                                    <Form.Control
                                                        className={"field"}
                                                        type="password" placeholder={t("enterPassword")}
                                                        name="password"
                                                        value={values.password}
                                                        onChange={handleChange}
                                                        isInvalid={!!errors.password}
                                                    />

                                                    {
                                                        !validator.isEmpty(values.password) &&
                                                        values.password.length <= 6 || values.password.length >= 18 ?
                                                            <p style={{
                                                                color: "#c7393d",
                                                                fontSize: "16px",
                                                                textAlign: "left",
                                                                marginTop: "10px"
                                                            }}>{t("ItMustBeGreaterThan6AndLessThan18")} </p> : null

                                                    }

                                                    <Form.Control.Feedback className="feedback" type="invalid" tooltip>
                                                        {errors.password}
                                                    </Form.Control.Feedback>
                                                </FloatingLabel>
                                            </Row>

                                           <Row className="inputs">


                                                <MaskedInput
                                                    className={"field"}
                                                    maskGenerator={maskGenerator}
                                                    value={phone === '' ? phone1 : phone}
                                                    onChange={setPhone}
                                                    style={{width: "98%", padding: "15px"}}
                                                    placeholder={"Mobile number"}

                                                />


                                                {

                                                    phone.length !== 10 && phone1.length !== 10 ? <p style={{
                                                        color: "#c7393d",
                                                        fontSize: "16px",
                                                        textAlign: "left",
                                                        marginTop: "30px"
                                                    }}>It must be 11 number</p> : null

                                                }

                                            </Row>


                                        </Form>
                                    </Col>

                                    <Col >
                                        <Form noValidate>
                                            {hide ?
                                                <ToastMsg show={hide} setShow={() => setHide(false)}
                                                          msg={msg}/>
                                                : null
                                            }

                                            <Row className="inputs">
                                                <FloatingLabel controlId="floatingEmail" className="label"
                                                               label={t("email")}>
                                                    <Form.Control
                                                        className={"field"}
                                                        type="email"
                                                        placeholder={t("email")}
                                                        aria-describedby="inputGroupPrepend"
                                                        name="email"
                                                        value={email||oldEmail}
                                                        onChange={handleChange}
                                                        isInvalid={!!errors.email}
                                                        disabled={true}
                                                    />
                                                    {/*{*/}
                                                    {/*    !validator.isEmpty(values.email) &&*/}
                                                    {/*    !validator.isEmail(values.email) ? <p style={{*/}
                                                    {/*        color: "#c7393d",*/}
                                                    {/*        fontSize: "16px",*/}
                                                    {/*        textAlign: "left",*/}
                                                    {/*        marginTop: "10px"*/}
                                                    {/*    }}>It must be*/}
                                                    {/*        example@domain.com</p> : setEmail(values.email)*/}
                                                    {/*}*/}

                                                    {/*<Form.Control.Feedback type="invalid" tooltip>*/}
                                                    {/*    {errors.email}*/}
                                                    {/*</Form.Control.Feedback>*/}
                                                </FloatingLabel>

                                            </Row>

                                            <Row className="inputs">

                                                <FloatingLabel controlId="floatingPassword" className="label"
                                                               label={t("confirmPassword")}>
                                                    <Form.Control
                                                        className={"field"}
                                                        type="password" placeholder={t("confirmPassword")}
                                                        name="confirmPassword"
                                                        value={values.confirmPassword}
                                                        onChange={handleChange}
                                                        isInvalid={!!errors.confirmPassword}
                                                    />
                                                    <Form.Control.Feedback className="feedback" type="invalid" tooltip>
                                                        {errors.confirmPassword}
                                                    </Form.Control.Feedback>
                                                    {
                                                        values.password !== values.confirmPassword ?
                                                            <p style={{
                                                                color: "#c7393d",
                                                                fontSize: "16px",
                                                                textAlign: "left",
                                                                marginTop: "10px"
                                                            }}>
                                                                {t("doesntMatch")}
                                                            </p>
                                                            : setPassword(values.password)
                                                    }

                                                </FloatingLabel>
                                            </Row>



                                             <Row className="inputs">

                                                <Form.Group className="mb-3 label">

                                                    <Form.Select
                                                        className={"field"}
                                                        name="gender"
                                                                 value={values.gender === '' ? gen : values.gender}
                                                                 onChange={handleChange}
                                                                 isInvalid={!!errors.gender}
                                                                 >
                                                        <option>{t("gender")}</option>
                                                        <option>{t("male")}</option>
                                                        <option>{t("female")}</option>
                                                    </Form.Select>
                                                    {setGender(values.gender)}
                                                </Form.Group>

                                                <br/>
                                                <Row className="inputs">
                                                    <Button className="buttonSubmit" disabled={upload && complete && phone.length !== 10 && phone1.length !== 10}
                                                            onClick={() => {
                                                                if (!user) {
                                                                    addUser()
                                                                } else {
                                                                    updateProfile()
                                                                }
                                                                setLoadButton(false);
                                                            }}>
                                                        {t("edit")}

                                                        {loadButton ?
                                                            null
                                                            :
                                                            <Spinner animation="border" size={"sm"}
                                                                     style={{color: "#ffffff", marginLeft: "8%"}}/>
                                                        }
                                                    </Button>
                                                </Row>
                                            </Row>

                                        </Form>
                                    </Col>
                                </Row>
                                </Container>
                            </Container>
                        )
                        :

                        <Load style={{width: "80px", height: "80px"}}/>

                )}
            </Formik>
        </Container>
    )
}

export default EditProfile;