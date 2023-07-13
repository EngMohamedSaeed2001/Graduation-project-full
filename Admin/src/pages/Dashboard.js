import React, {useEffect, useState} from 'react'
import InfoCard from '../components/Cards/InfoCard'
import ChartCard from '../components/Chart/ChartCard'
import {Doughnut, Line} from 'react-chartjs-2'
import ChartLegend from '../components/Chart/ChartLegend'
import PageTitle from '../components/Typography/PageTitle'
import {Building, CartIcon, MailIcon, MoneyIcon, PeopleIcon, TrashIcon} from '../icons'
import RoundIcon from '../components/RoundIcon'
import moment from 'moment';


import {
    Avatar,
    Button,
    Table,
    TableBody,
    TableCell,
    TableContainer,
    TableFooter,
    TableHeader,
    TableRow,
} from '@windmill/react-ui'

import {doughnutLegends, lineLegends,} from '../utils/demo/chartsData'
import Form from "react-bootstrap/Form";
import {Link} from "react-router-dom";
import PendingRequests from "./PendingRequests";
import {useTranslation} from "react-i18next";
import Api from "../utils/Base";
import {all} from "axios";



function Dashboard() {
    let [page, setPage] = useState(1)
    let [data, setData] = useState([])
    let [thisYear, setThisYear] = useState([])
    let [lastYear, setLastYear] = useState([])
    let [users,setUsers]=useState([])
    let [ads,setAds]=useState([])
    let [pend,setPend]=useState([])


    const [verify, setVerify] = useState(false);
    const [suspend, setSuspend] = useState(false);
    const [open, setOpen] = useState(false);
    const [id, setId] = useState('0');

    const {t} = useTranslation()


     let allUsers=()=> {
        Api.apiToken.get("admin/getAllUsers").then((res) => {
            if (res.status === 200) {
                setUsers(res.data)
            }

        }).catch((e) => {

            console.log(e.response.data.message)

        })
    }

     let doughnutOptions = {
    data: {
        datasets: [
            {
                data: [users.length, 4],
                /**
                 * These colors come from Tailwind CSS palette
                 * https://tailwindcss.com/docs/customizing-colors/#default-color-palette
                 */
                backgroundColor: ['#0694a2', '#7e3af2'],
                label: 'Dataset 1',
            },
        ],
        labels: [ 'Free', 'Premium'],
    },
    options: {
        responsive: true,
        cutoutPercentage: 80,
    },
    legend: {
        display: false,
    },
}

///=========================================================
     function allAds() {
        Api.apiToken.get("common/getAllAds").then((res) => {
            if (res.status === 200) {
                setAds(res.data)
                setThisYear(res.data.filter((item)=>{

                    return parseInt(item.date.slice(0,4))===parseInt(currentDate.toString().slice(0,4));
                }))

                setLastYear(res.data.filter((item)=>{
                    return parseInt(item.date.slice(0,4))<parseInt(currentDate.toString().slice(0,4));
                }))

            }

        }).catch((e) => {

            console.log(e.response.data.message)

        })
    }

const currentDate = moment().format('YYYY-MM-DD');





//===============================================================

    function allPending() {
         Api.apiToken.get("admin/getAllPendingUsers").then((res) => {
            if (res.status === 200) {
                setPend(res.data)
            }

        }).catch((e) => {

        })
    }

//===============================================================

    const deleteUser = (id,email) => {
        setOpen(true);
        document.getElementById(id).style.display = "none";

         Api.apiToken.delete("admin/deleteUser",{
            email:email
        }).then((res) => {
            if (res.status === 200) {
            }

        }).catch((e) => {
            console.log(e.response.data.message)
        })

    }

     const deleteAd = (id) => {
        setOpen(true);
        document.getElementById(id).style.display = "none";

         Api.apiToken.delete(`admin/deleteAd/${id}`).then((res) => {
            if (res.status === 200) {
            }
        }).catch((e) => {
            console.log(e.response.data.message)
        })

    }

    function _suspend(email) {
        Api.apiToken.post("admin/suspendUser",{
            email:email
        }).then((res) => {
            if (res.status === 200) {
            }

        }).catch((e) => {
            console.log(e.response.data.message)
        })
    }

    function _unSuspend(email) {
        Api.apiToken.post("admin/unSuspendUser",{
            email:email
        }).then((res) => {
            if (res.status === 200) {
            }

        }).catch((e) => {
            console.log(e.response.data.message)
        })
    }

    function _unVerify(email) {
        Api.apiToken.post("admin/unVerifyUser",{
            email:email
        }).then((res) => {
            if (res.status === 200) {
            }

        }).catch((e) => {
            console.log(e.response.data.message)
        })

    }

    function _verify(email) {
        Api.apiToken.post("admin/verifyUser",{
            email:email
        }).then((res) => {
            if (res.status === 200) {
            }

        }).catch((e) => {
            console.log(e.response.data.message)
        })

    }


    // pagination setup
    const resultsPerPage = 10
    let totalResults = users.length

    // pagination change control
    function onPageChange(p) {
        setPage(p)
    }


    useEffect(() => {
        let canc = false;
        if (!canc) {
            setTimeout(() => {
               allUsers()
                //setData(users.slice((page - 1) * resultsPerPage, page * resultsPerPage))
                allAds()
                allPending()

console.log(thisYear)
            }, 1000)
        }
        return () => {
            canc = true;
        }

    },[])


    let lineOptions = {
    data: {
        labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July'],
        datasets: [
            {
                label: 'This Year',
                /**
                 * These colors come from Tailwind CSS palette
                 * https://tailwindcss.com/docs/customizing-colors/#default-color-palette
                 */
                backgroundColor: '#0694a2',
                borderColor: '#0694a2',
                data: ads.filter((item)=>{

                    return parseInt(item.date.slice(0,4))===parseInt(currentDate.toString().slice(0,4));
                }),
                fill: false,
            },
            {
                label: 'Last Year',
                fill: false,
                /**
                 * These colors come from Tailwind CSS palette
                 * https://tailwindcss.com/docs/customizing-colors/#default-color-palette
                 */
                backgroundColor: '#7e3af2',
                borderColor: '#7e3af2',
                data: lastYear,
            },
        ],
    },
    options: {
        responsive: true,
        tooltips: {
            mode: 'index',
            intersect: false,
        },
        hover: {
            mode: 'nearest',
            intersect: true,
        },
        scales: {
            x: {
                display: true,
                scaleLabel: {
                    display: true,
                    labelString: 'Month',
                },
            },
            y: {
                display: true,
                scaleLabel: {
                    display: true,
                    labelString: 'Value',
                },
            },
        },
    },
    legend: {
        display: false,
    },
}

    return (
        <>
            <PageTitle>{t("dashboard")}</PageTitle>

            {/* <!-- Cards --> */}
            <div className="grid gap-6 mb-8 md:grid-cols-2 xl:grid-cols-4">
                <InfoCard title={t("customers")} value={users.length}>
                    <RoundIcon
                        icon={PeopleIcon}
                        iconColorClass="text-orange-500 dark:text-orange-100"
                        bgColorClass="bg-orange-100 dark:bg-orange-500"
                        className="mr-4"
                    />
                </InfoCard>

                {/*<InfoCard title="Balance" value="$ 46,760.89">*/}
                {/*    <RoundIcon*/}
                {/*        icon={MoneyIcon}*/}
                {/*        iconColorClass="text-green-500 dark:text-green-100"*/}
                {/*        bgColorClass="bg-green-100 dark:bg-green-500"*/}
                {/*        className="mr-4"*/}
                {/*    />*/}
                {/*</InfoCard>*/}

                {/*<InfoCard title="Profit" value="$ 49,760.89">*/}
                {/*    <RoundIcon*/}
                {/*        icon={MoneyIcon}*/}
                {/*        iconColorClass="text-teal-500 dark:text-teal-100"*/}
                {/*        bgColorClass="bg-teal-100 dark:bg-teal-500"*/}
                {/*        className="mr-4"*/}
                {/*    />*/}
                {/*</InfoCard>*/}

                <InfoCard title={t("apartments")} value={ads.length}>
                    <RoundIcon
                        icon={Building}
                        iconColorClass="text-blue-500 dark:text-blue-100"
                        bgColorClass="bg-blue-100 dark:bg-blue-500"
                        className="mr-4"
                    />
                </InfoCard>

                <InfoCard title={t("PendingRequests")} value={pend.length}>
                    <RoundIcon
                        icon={MailIcon}
                        iconColorClass="text-blue-500 dark:text-blue-100"
                        bgColorClass="bg-blue-100 dark:bg-blue-500"
                        className="mr-4"
                    />
                </InfoCard>

                <InfoCard title={t("OrdersComingSoon")} value="">
                    <RoundIcon
                        icon={CartIcon}
                        iconColorClass="text-blue-500 dark:text-blue-100"
                        bgColorClass="bg-blue-100 dark:bg-blue-500"
                        className="mr-4"
                    />
                </InfoCard>


            </div>

            <PageTitle>{t("customers")}</PageTitle>
            <TableContainer>
                <Table>
                    <TableHeader>
                        <tr>
                            <TableCell>{t("client")}</TableCell>
                            <TableCell>{t("email")}</TableCell>
                            <TableCell>{t("phone")}</TableCell>
                            <TableCell>{t("rate")}</TableCell>
                            <TableCell>{t("suspend")}</TableCell>
                            <TableCell>{t("action")}</TableCell>
                        </tr>
                    </TableHeader>
                    <TableBody>
                        {users.map((user, i) => (
                            i < 4 ? <TableRow key={i} id={user.id}>
                                <TableCell>
                                    <div className="flex items-center text-sm">
                                        <Avatar className="hidden mr-3 md:block"
                                                src={user.img ? user.img : '/static/images/avatars/avatar.png'}
                                                alt="User avatar"/>
                                        <div>
                                            <p className="font-semibold">{user.username}</p>
                                        </div>
                                    </div>
                                </TableCell>
                                <TableCell>
                                    <span className="text-sm">{user.email}</span>
                                </TableCell>
                                <TableCell>
                                    <p className={"font-semibold"}>{'0'+user.phone}</p>
                                </TableCell>
                                <TableCell>
                                  <p className={"font-semibold"}>{user.rate}</p>
                                </TableCell>

                                <TableCell>
                                  <span className="text-sm">
                                     <Form.Check
                                         type="switch"
                                         id="custom-switch"
                                         checked={user.suspended}

                                         onChange={() => {
                                             if(user.suspended)
                                                 _unSuspend(user.email)
                                             else
                                                 _suspend(user.email)
                                         }}

                                     />
                                  </span>
                                </TableCell>
                                <TableCell>
                                    <div className="flex items-center space-x-4">
                                        <Button layout="link" size="icon" aria-label="Delete"
                                                onClick={() => deleteUser(user.id,user.email)}>
                                            <TrashIcon className="w-5 h-5" aria-hidden="true"/>
                                        </Button>
                                    </div>
                                </TableCell>
                            </TableRow> : <></>
                        ))}
                    </TableBody>
                </Table>
                <TableFooter>
                    <div className="px-6 my-6">
                        <Button tag={Link} to="/app/customers">
                            {t("show")}
                            <span className="ml-2" aria-hidden="true">
            ->
          </span>
                        </Button>
                    </div>
                </TableFooter>
            </TableContainer>

            <PageTitle>{t("apartments")}</PageTitle>
            <TableContainer>
                <Table>
                    <TableHeader>
                        <tr>
                             <TableCell>{t("buildingId")}</TableCell>
                            <TableCell>{t("Title")}</TableCell>
                            <TableCell>{t("date")}</TableCell>
                            <TableCell>{t("location")}</TableCell>
                            <TableCell>{t("client")}</TableCell>
                            <TableCell>{t("phone")}</TableCell>
                            <TableCell>{t("views")}</TableCell>
                            <TableCell>{t("action")}</TableCell>
                        </tr>
                    </TableHeader>
                    <TableBody>
                        {ads.map((item, i) => (
                            i < 4 ?   <TableRow key={i} id={item.id}>
                                <TableCell>
                                    <span className="text-sm">{item.id}</span>
                                </TableCell>
                                  <TableCell>
                                    <span className="text-sm">{item.title}</span>
                                </TableCell>
                                 <TableCell>
                                    <span className="text-sm">{item.date}</span>
                                </TableCell>
                                 <TableCell>
                                    <span className="text-sm">{item.gov}/{item.city}</span>
                                </TableCell>
                                <TableCell>
                                    <div className="flex items-center text-sm">
                                        <Avatar className="hidden mr-3 md:block"
                                                src={item.photosList[0] ? item.photosList[0] : '/static/images/avatars/avatar.png'}
                                                alt="User avatar"/>
                                        <div>
                                            <p className="font-semibold">{item.user.email}</p>
                                        </div>

                                    </div>
                                </TableCell>

                                <TableCell>
                                    <p className={"font-semibold"}>{'0'+item.user.phone}</p>
                                </TableCell>

                                <TableCell>
                                    <span className="text-sm">{item.views}</span>
                                </TableCell>

                                <TableCell>
                                    <div className="flex items-center space-x-4">
                                        <Button layout="link" size="icon" aria-label="Delete"
                                                onClick={() => deleteAd(item.id)}>
                                            <TrashIcon className="w-5 h-5" aria-hidden="true"/>
                                        </Button>
                                    </div>
                                </TableCell>
                            </TableRow> : <></>
                        ))}
                    </TableBody>
                </Table>
                <TableFooter>
                    <div className="px-6 my-6">
                        <Button tag={Link} to="/app/apartments">
                            {t("show")}
                            <span className="ml-2" aria-hidden="true">
            ->
          </span>
                        </Button>
                    </div>
                </TableFooter>
            </TableContainer>


            <PageTitle>{t("PendingRequests")}</PageTitle>
            <TableContainer>
                <Table>
                    <TableHeader>
                        <tr>
                            <TableCell>{t("client")}</TableCell>
                            <TableCell>{t("email")}</TableCell>
                            <TableCell>{t("phone")}</TableCell>
                            <TableCell>{t("PersonalImage")}</TableCell>
                            <TableCell>{t("NationalIDImage")}</TableCell>
                            <TableCell>{t("verify")}</TableCell>
                            <TableCell>{t("Actions")}</TableCell>
                        </tr>
                    </TableHeader>
                    <TableBody>
                        {pend.map((item, i) => (
                            i < 4 ? <TableRow key={i} id={item.id}>
                                <TableCell>
                                    <div className="flex items-center text-sm">
                                        <Avatar className="hidden mr-3 md:block"
                                                src={item.img ? item.img : '/static/images/avatars/avatar.png'}
                                                alt="User avatar"/>
                                        <div>
                                            <p className="font-semibold">{item.username}</p>
                                        </div>
                                    </div>
                                </TableCell>
                                <TableCell>
                                    <span className="text-sm">{item.email}</span>
                                </TableCell>
                                <TableCell>
                                    <p className={"font-semibold"}>{'0'+item.phone}</p>
                                </TableCell>
                                <TableCell>
                                  <a target={"_blank"} href={item.personalImg} className={"font-semibold"}>open personal image</a>
                                </TableCell>

                                <TableCell>
                                    <a target={"_blank"} href={item.idImg} className={"font-semibold"}>open National ID image</a>
                                </TableCell>

                                <TableCell>
                                  <span className="text-sm">
                                     <Form.Check
                                         type="switch"
                                         id="custom-switch"
                                        checked={item.verifyID}

                                         onChange={() => {
                                             if(item.verifyID)
                                                 _unVerify(item.email)
                                             else
                                                 _verify(item.email)
                                         }}
                                     />
                                  </span>
                                </TableCell>
                                <TableCell>
                                    <div className="flex items-center space-x-4">
                                        <Button layout="link" size="icon" aria-label="Delete"
                                                onClick={() => deleteUser(item.id,item.email)}>
                                            <TrashIcon className="w-5 h-5" aria-hidden="true"/>
                                        </Button>
                                    </div>
                                </TableCell>
                            </TableRow> : <></>
                        ))}
                    </TableBody>
                </Table>
                <TableFooter>
                    <div className="px-6 my-6">
                        <Button tag={Link} to="/app/pendingRequests">
                            {t("show")}
                            <span className="ml-2" aria-hidden="true">
            ->
          </span>
                        </Button>
                    </div>
                </TableFooter>
            </TableContainer>

            <PageTitle>{t("OrdersComingSoon")}</PageTitle>

          {/*  <TableContainer>*/}
          {/*      <Table>*/}
          {/*          <TableHeader>*/}
          {/*              <tr>*/}
          {/*                  <TableCell>Seller</TableCell>*/}
          {/*                  <TableCell>Email</TableCell>*/}
          {/*                  <TableCell>Phone</TableCell>*/}
          {/*                  <TableCell>Buyer</TableCell>*/}
          {/*                  <TableCell>Email</TableCell>*/}
          {/*                  <TableCell>Phone</TableCell>*/}
          {/*              </tr>*/}
          {/*          </TableHeader>*/}
          {/*          <TableBody>*/}
          {/*              {data.map((user, i) => (*/}
          {/*                  i < 4 ? <TableRow key={i} id={user.id}>*/}
          {/*                      <TableCell>*/}
          {/*                          <div className="flex items-center text-sm">*/}
          {/*                              <Avatar className="hidden mr-3 md:block"*/}
          {/*                                      src={user.avatar ? user.avatar : '/static/images/avatars/avatar.png'}*/}
          {/*                                      alt="User avatar"/>*/}
          {/*                              <div>*/}
          {/*                                  <p className="font-semibold">{user.name}</p>*/}
          {/*                              </div>*/}
          {/*                          </div>*/}
          {/*                      </TableCell>*/}
          {/*                      <TableCell>*/}
          {/*                          <span className="text-sm">{user.email}</span>*/}
          {/*                      </TableCell>*/}
          {/*                      <TableCell>*/}
          {/*                          <p className={"font-semibold"}>{user.phone}</p>*/}
          {/*                      </TableCell>*/}

          {/*                      <TableCell>*/}
          {/*                          <div className="flex items-center text-sm">*/}
          {/*                              <Avatar className="hidden mr-3 md:block"*/}
          {/*                                      src={user.avatar ? user.avatar : '/static/images/avatars/avatar.png'}*/}
          {/*                                      alt="User avatar"/>*/}
          {/*                              <div>*/}
          {/*                                  <p className="font-semibold">{user.name}</p>*/}
          {/*                              </div>*/}
          {/*                          </div>*/}
          {/*                      </TableCell>*/}
          {/*                      <TableCell>*/}
          {/*                          <span className="text-sm">{user.email}</span>*/}
          {/*                      </TableCell>*/}
          {/*                      <TableCell>*/}
          {/*                          <p className={"font-semibold"}>{user.phone}</p>*/}
          {/*                      </TableCell>*/}

          {/*                  </TableRow> : <></>*/}
          {/*              ))}*/}
          {/*          </TableBody>*/}
          {/*      </Table>*/}
          {/*      <TableFooter>*/}
          {/*          <div className="px-6 my-6">*/}
          {/*              <Button tag={Link} to="/app/orders">*/}
          {/*                  View*/}
          {/*                  <span className="ml-2" aria-hidden="true">*/}
          {/*  ->*/}
          {/*</span>*/}
          {/*              </Button>*/}
          {/*          </div>*/}
          {/*      </TableFooter>*/}
          {/*  </TableContainer>*/}

            <PageTitle>{t("statistics")}</PageTitle>
            <div className="grid gap-6 mb-8 md:grid-cols-2">
                <ChartCard title={t("PremiumAndFreeUsers")}>
                    <Doughnut {...doughnutOptions} />
                    <ChartLegend legends={doughnutLegends}/>
                </ChartCard>

                <ChartCard title={t("ads")}>
                    <Line {...lineOptions} />
                    <ChartLegend legends={lineLegends}/>
                </ChartCard>
            </div>
        </>
    )
}

export default Dashboard
