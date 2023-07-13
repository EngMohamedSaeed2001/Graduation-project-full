import {lazy} from 'react'
import Apartment from "../pages/Apartments";
import Orders from "../pages/Orders";
import PendingRequests from "../pages/PendingRequests";

// use lazy for better code splitting, a.k.a. load faster
const Dashboard = lazy(() => import('../pages/Dashboard'))

const Customers = lazy(() => import('../pages/Customers'))
const Page404 = lazy(() => import('../pages/404'))


const routes = [
    {
        path: '/dashboard', // the url
        component: Dashboard, // view rendered
    },

    {
        path: '/customers',
        component: Customers,
    },
    {
        path: '/pendingRequests',
        component: PendingRequests,
    },
    {
        path: '/apartments',
        component: Apartment,
    },
    {
        path: '/orders',
        component: Orders,
    },
    {
        path: '/404',
        component: Page404,
    }
]

export default routes
