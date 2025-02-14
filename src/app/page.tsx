import { fetchStuff } from './lib/data';
import styles from './page.module.css';

export default async function Home() {
    const test = await fetchStuff();

    return (
        <div className={styles.page}>
            <main className={styles.main}>
                {test.map((item) => (
                    <h1>{item.col}</h1>
                ))}
            </main>
            <footer className={styles.footer}></footer>
        </div>
    );
}
