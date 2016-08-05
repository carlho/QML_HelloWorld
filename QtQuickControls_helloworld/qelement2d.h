#ifndef QELEMENT2D_H
#define QELEMENT2D_H

#include <QtQuick/QQuickItem>

class QElement2d : public QQuickItem
{
    Q_OBJECT

    Q_PROPERTY(QPointF p1 READ p1 WRITE setP1 NOTIFY p1Changed)
    Q_PROPERTY(QPointF p2 READ p2 WRITE setP2 NOTIFY p2Changed)

    // Test
    Q_PROPERTY(double x2 READ x2 WRITE setX2 NOTIFY p2Changed)
    Q_PROPERTY(double y2 READ y2 WRITE setY2 NOTIFY p2Changed)
    // Test

public:
    QElement2d(QQuickItem *parent = 0);
    ~QElement2d();

    // Synchronisation point between the QML scene and the rendering scene graph
    // which all items with custom scene graph logic must implement.
    QSGNode *updatePaintNode(QSGNode *, UpdatePaintNodeData *);

    QPointF p1() const { return m_p1; }
    QPointF p2() const { return m_p2; }

    // Test
    double x2() const { return m_p2.x(); }
    double y2() const { return m_p2.y(); }
    // Test

    void setP1(const QPointF &p);
    void setP2(const QPointF &p);

    // Test
    void setX2(const double x2) { setP2(QPointF(x2, m_p2.y()));}
    void setY2(const double y2) { setP2(QPointF(m_p2.x(), y2));}
    // Test

signals:
    void p1Changed(const QPointF &p);
    void p2Changed(const QPointF &p);

private:
    QPointF m_p1;
    QPointF m_p2;
};

#endif // QELEMENT2D_H
